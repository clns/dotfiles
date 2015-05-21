# Install PostgreSQL

if is_osx && ! formula_exists 'postgresql'; then
    prompt "Install PostgreSQL."
    if ! is_confirmed; then return 0; fi
    brew install postgresql
elif is_ubuntu && ! service --status-all |& grep -Fq 'postgresql'; then
    prompt "Install PostgreSQL for 'trusty'."
    if ! is_confirmed; then return 0; fi

    # Installing PostgreSQL according to:
    # https://github.com/jackdb/pg-app-dev-vm
    # https://wiki.postgresql.org/wiki/Apt

    DB_USER=$(whoami)
    PG_VERSION=9.4
    if ! apt_repository_exists 'pgdb'; then
        # Add PG apt repo:
        echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee "/etc/apt/sources.list.d/pgdg.list"

        # Add PGDG repo key:
        wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

        # Update package list and upgrade all packages
        sudo apt-get update
        # apt-get -y upgrade
    fi

    sudo apt-get -y install "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION"

    PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
    PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
    PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

    # Edit postgresql.conf to change listen address to '*':
    sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

    # Append to pg_hba.conf to add trust auth for user postgres
    # echo "host    all    all    all    trust" | sudo tee --append "$PG_HBA"
    # Insert at the beginning so it works
    sudo sed -i '1s/^/local    all    all    trust\nhost    all    all    all    trust\n/' "$PG_HBA"

    # Explicitly set default client_encoding
    echo "client_encoding = utf8" | sudo tee --append "$PG_CONF"

    # Restart so that all new config is loaded:
    sudo service postgresql restart

    # Create a user named "vagrant" that can create databases
    sudo -u postgres createuser --createdb "$DB_USER"
else
    log_arrow "PostgreSQL is installed"
fi

log_warning 'Set timezone="UTC" in postgresq.conf (usually at /usr/local/var/postgres/)'
# http://justatheory.com/computers/databases/postgresql/use-timestamptz.html

