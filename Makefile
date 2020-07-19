.DEFAULT_GOAL := run
.PHONY: clean


CTIMESTAMP=$(shell date +%Y%m%d%H%M%S)

SITE=kfrajer-site
DEPLOY_DIR=published
TRASH=Trash
BACKUP_DIR=~/bacup/hugo-site
LOGFILE=log-backups.log

info:
	@ echo "Stream line instructions to generate and deploy resources";
	@ echo "Options: info, run, serve, build, deploy, clean, tar";

serve: 
	@ echo "Serving..."
	hugo server

run: serve
	@ echo "Running..."

build: 
	hugo -d $(DEPLOY_DIR)/

deploy:
	@ echo "To be done..."

tar:
	mkdir -p $(BACKUP_DIR)
	tar -cvf $(BACKUP_DIR)/$(SITE)_$(CTIMESTAMP).tar *
	echo "Backup created at $(BACKUP_DIR)/$(SITE)_$(CTIMESTAMP).tar"

clean:
	@ echo "Cleaning up..."
	mkdir -p $(TRASH)
	#mv -f $(DEPLOY_DIR) $(TRASH)/ || true
	FILES="$(shell find -type f -name '*.*~' -o -name '*~')"; mv -f $$FILES $(TRASH) || true
	@ echo "Cleaning up... DONE"
	