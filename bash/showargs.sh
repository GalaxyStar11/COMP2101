#!/bin/bash

cmdname="$(basename $0)"

cat <<EOF

there are $# things on the command line after the command

the variable 1 has '$1' in it
the variable 2 has '$2' in it
the variable 3 has '$3' in it

the variable 0 has '$0' in it

so the command that was run to run this script was $cmdname

interesting, innit?

now we shift things left

EOF

shift

cat <<EOF
after shifting, this is what we have left
there are $# things on the command line after the command

the variable 1 has '$1' in it
the variable 2 has '$2' in it
the variable 3 has '$3' in it

the variable 0 has '$0' in it

so the command that was run to run this script was $cmdname

interesting, innit?

now we shift things left

EOF

