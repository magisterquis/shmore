# readsrc.awk
# Read a source file, less leading comments and vim modeline
# By J. Stuart McMurray
# Created 20241109
# Last Modified 20241109

# Skip the leading comments
1 == FNR , /^$/ {
        next
}

# Skip vim modelines
/^# vim/ {
        next
}

# Print the rest of the file
//
