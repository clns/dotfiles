The scripts here **must** work everywhere, including on systems that lack
a /bin/bash, map 'sh' to ksh, ksh97, bash, ash, or zsh,
and potentially have either a posix shell or bourne
shell living at /bin/sh.

See this helpful document on writing portable shell scripts:
http://www.gnu.org/s/hello/manual/autoconf/Portable-Shell.html.

The only shell it won't ever work on is cmd.exe.

This is inspired by the npm install:
`curl https://www.npmjs.org/install.sh | sh`

## Usage

To install something from here simply run this from any shell - don't forget
to replace `<NAME>`:

```sh
curl https://raw.githubusercontent.com/clns/dotfiles/master/install/<NAME>.sh | sh
```
