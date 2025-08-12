#!/usr/bin/env python3

from pathlib import Path
import subprocess
import re
import sys

COREDIR = Path(__file__).parent.parent / "core"

updates = 0
version_scripts = list(COREDIR.glob("*/version"))

for vscript in version_scripts:
    pkg = vscript.parent.name
    res = subprocess.run([vscript], capture_output=True, text=True, encoding="utf-8", check=False)
    if res.returncode != 0:
        print(f"version script invoked at {vscript} encountered an exit code of {res.returncode}")
        continue
    latest = res.stdout.strip()

    build = (vscript.parent / "build").read_text(encoding="utf-8")
    version = re.search(r'VERSION\=\"(.*)\"', build)
    if version is None:
        print(f"Package {pkg} has no registered version, skipping")
        continue

    assert version is not None
    current = version.group(1)

    if latest != current:
        updates += 1
        print(f"The package {pkg} has a latest version of {latest} " 
            f"but we are currently in {current}")

print("Note that perl, tzinfo, make, and other packages require manual updating")
if updates:
    print(f"{updates}/{len(version_scripts)} packages require updating. "
        "Please update the $VERSION variable as specified in each package's ./build script.")
    sys.exit(1)
