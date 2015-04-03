# Install PostgreSQL

if is_osx && ! formula_exists 'postgresql'; then
    prompt "Install PostgreSQL."
    if ! is_confirmed; then return 0; fi
    brew install postgresql
elif is_ubuntu; then
    log_error "TODO: implement this for Ubuntu"
    return 0
else
    log_arrow "PostgreSQL is installed"
fi

log_warning 'Set timezone="UTC" in postgresq.conf (usually at /usr/local/var/postgres/)'
# http://justatheory.com/computers/databases/postgresql/use-timestamptz.html

