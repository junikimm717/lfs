# Mimux Monitor

A simple subproject for running a version monitoring server for mimux. It
provides several main functionalities:

- an endpoint for shields.io to generate mimux core badges from
- a front page to see which packages are up-to-date
- endpoints for the CI to update our server with the latest package versions.

The production site can be viewed at [mxm.mit.junic.kim](https://mxm.mit.junic.kim)

## Development Setup

This subproject is structured as a standard go project, not much to say here.

Some environment variables, such as `MIMUX_API_KEY`, will be needed for
testing, so you should copy them over. Before running testing, you should also
run the versions.py script so that `/dist/mimux_updates.json` is actually
generated.

```sh
cd {this directory}
# .env file which contains default environment variables values.
cp ./.env.example .env
# run the versions.py script first.
../tools/versions.py
```

## The Binary

The binary itself is structured with the following subcommands:

- `serve -P {port} -S {save file}` - the command to start a server. Note
  the save file **will get overwritten** on each update, so by default, it's set
  to `/tmp/mimuxserver_save.json`

- `delete -U {baseurl} -P package1,package2,...` - a pure debugging command to
  delete any packages that are now obsolete/no longer needed.
- `send -P {updates_list file} -U {baseurl}` -  the command to send updates to
  the mimux monitor server.

### Use Cases

Here are the most common ways you should expect to use the above commands,
given that you are using the default setup as described above.

```sh
# assuming the parent directory of this readme file is your pwd.
go run . serve
go run . send -P ../dist/mimux_updates.json -U http://localhost:1434
go run . delete -P package1,package2 -U http://localhost:1434
```
