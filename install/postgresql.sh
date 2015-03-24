# Install PostgreSQL

if is_osx && ! formula_exists 'postgresql'; then
    brew install postgresql
elif is_ubuntu; then
    log_error "TODO: implement this for Ubuntu"
    exit 1
else
    log_arrow "PostgreSQL is installed"
fi

log_warning 'Set timezone="UTC" in postgresq.conf (usually at /usr/local/var/postgres/)'
# http://justatheory.com/computers/databases/postgresql/use-timestamptz.html

