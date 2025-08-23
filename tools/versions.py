#!/usr/bin/env python3

from pathlib import Path
import subprocess
import re
import sys
import json
from dataclasses import dataclass

COREDIR = Path(__file__).parent.parent / "core"
DISTDIR = Path(__file__).parent.parent / "dist"


@dataclass
class OutOfDate:
    name: str
    devmit: bool
    current: str
    expected: str

    def msg(self):
        return (
            f"{self.name} {'(installs from dev.mit.junic.kim!!) ' if self.devmit else ''}"
            f"is set to {self.current} (Expected {self.expected})"
        )


updates: "list[OutOfDate]" = []
version_scripts = list(COREDIR.glob("*/version"))
cidata: dict[str, dict[str, str]] = {}

for idx, vscript in enumerate(version_scripts):
    # run the ./version script to extract the latest version of our package.
    pkg = vscript.parent.name
    sys.stderr.write(
        f"[{idx+1:>2}/{len(version_scripts)}] Checking that {pkg:<11} is up-to-date..."
    )
    sys.stderr.flush()
    res = subprocess.run(
        [vscript], capture_output=True, text=True, encoding="utf-8", check=False
    )
    if res.returncode != 0:
        sys.stderr.write("\033[1;33mINCOMPLETE\033[0m ")
        sys.stderr.write(
            f"version script invoked at {vscript} encountered an exit code of {res.returncode}"
        )
        sys.stderr.write("\n")
        sys.stderr.flush()
        continue

    latest = res.stdout.strip()
    if not latest:
        sys.stderr.write("\033[1;33mINCOMPLETE\033[0m ")
        sys.stderr.write(
            f"Invoked {vscript} has an empty output, skipping: {res.stderr}"
        )
        sys.stderr.write("\n")
        sys.stderr.flush()
        continue

    # Try to extract a VERSION="xyz" declaration from the build script.
    build = (vscript.parent / "build").read_text(encoding="utf-8")
    version = re.search(r"VERSION\=\"(.*)\"", build)
    if version is None:
        print(f"Package {pkg} has no registered version, skipping")
        continue

    assert version is not None
    current = version.group(1)

    cidata[pkg] = {"current": current, "latest": latest}

    # some packages download from Juni's mirror (bc gnu mirrors suck occasionally)
    # These should be highlighted, as there is no guarantee the tarballs will actually be there.
    devmit = "https://dev.mit.junic.kim" not in build
    if latest != current:
        updates.append(
            OutOfDate(name=pkg, devmit=devmit, current=current, expected=latest)
        )
        sys.stderr.write("\033[1;31mNo\033[0m\n")
        sys.stderr.flush()
    else:
        sys.stderr.write("\033[1;32mYes\033[0m\n")
        sys.stderr.flush()


(DISTDIR / "mimux_updates.json").write_text(json.dumps(cidata, indent=2), encoding="utf-8")

if updates:
    print(
        f"{len(updates)}/{len(version_scripts)} packages seem out-of-date. "
        "Please update the $VERSION variable as specified in each package's ./build script."
    )
    for ood in updates:
        print(ood.msg())
    sys.exit(1)
