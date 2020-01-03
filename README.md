

# Backup with PG_DUMP
- Create build : `oc new-build https://github.com/jdauphant/postgresql-openshift-docker --context-dir=pg-dump-backup --name pg-dump-backup` (you may need to setup limit and request ressources if your cluster enforce it)
- Create backup job and run it one : `oc create -f job-run-once.yaml`
- Create regular backup job via cron jobs : `oc create -f job-cron-run.yaml`


# Command
- Launch debug shell : `oc run -i -t "pg-bash-$(date +%s)"  --restart=Never --image=centos/postgresql-10-centos7 --limits='cpu=100m,memory=256Mi' --requests='cpu=100m,memory=256Mi' --command -- "/bin/bash"`
- Restore a custom-dump (with data removal) : `pg_restore --if-exist --clean -d postgres://user:pass@host:5432/db db-dump`

# Generate a gpg key
```
gpg --gen-key
```

# How to pass the public key to the container ?
The container expects the public key to be base64 encoded and passed as the env var 'RECIPIENT_PUBLIC_KEY_B64'.

# Decrypt the backup
```
gpg --output backup --decrypt backup.gpg
```
