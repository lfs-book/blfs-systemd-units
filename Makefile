SHELL=/bin/bash

EXTDIR=${DESTDIR}/etc
DEFAULTSDIR=${DESTDIR}/etc/default
SERVICEDIR=${DESTDIR}/usr/lib/services
TMPFILESDIR=${DESTDIR}/usr/lib/tmpfiles.d
UNITSDIR=${DESTDIR}/usr/lib/systemd/system
MODE=755
DIRMODE=755
CONFMODE=644

all:
	@grep "^install" Makefile | cut -d ":" -f 1
	@echo "Select an appropriate install target from the above list"

create-dirs:
	install -d -m ${DIRMODE} ${DEFAULTSDIR}
	install -d -m ${DIRMODE} ${TMPFILESDIR}
	install -d -m ${DIRMODE} ${UNITSDIR}

install-acpid: create-dirs
	install -m ${CONFMODE} blfs/units/acpid.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/acpid.socket ${UNITSDIR}/

install-exim: create-dirs
	install -m ${CONFMODE} blfs/units/exim.service ${UNITSDIR}/

install-git-daemon: create-dirs
	install -m ${CONFMODE} blfs/default/git-daemon ${DEFAULTSDIR}/
	install -m ${CONFMODE} blfs/units/git-daemon.service ${UNITSDIR}/

install-gpm: create-dirs
	install -m ${CONFMODE} blfs/units/gpm.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/gpm.path    ${UNITSDIR}/

install-httpd: create-dirs
	install -m ${CONFMODE} blfs/tmpfiles/httpd.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/httpd.service ${UNITSDIR}/
	systemd-tmpfiles --create httpd.conf

install-iptables: create-dirs
	install -m ${CONFMODE} blfs/units/iptables.service ${UNITSDIR}/

install-kea-dhcpd: create-dirs
	install -m ${CONFMODE} blfs/units/kea-* ${UNITSDIR}/
	install -m ${CONFMODE} blfs/tmpfiles/kea.conf ${TMPFILESDIR}/
	systemd-tmpfiles --create kea.conf

install-krb5: create-dirs
	install -m ${CONFMODE} blfs/units/krb5-kdc.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/krb5-kpropd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/krb5-kadmind.service ${UNITSDIR}/

install-lightdm: create-dirs
	install -m ${CONFMODE} blfs/units/lightdm.service ${UNITSDIR}/

install-mariadb: create-dirs
	install -m ${CONFMODE} blfs/tmpfiles/mariadb.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/mariadb.service ${UNITSDIR}/
	systemd-tmpfiles --create mariadb.conf

install-named: create-dirs
	install -m ${CONFMODE} blfs/tmpfiles/named.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/named.service ${UNITSDIR}/
	systemd-tmpfiles --create named.conf

install-nfs-client: create-dirs
	install -m ${CONFMODE} blfs/default/nfs-utils ${DEFAULTSDIR}/
	install -m ${CONFMODE} blfs/units/rpc-statd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/rpc-statd-notify.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/nfs-client.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/nfs-client.target ${UNITSDIR}/

install-nfs-server: install-nfs-client
	install -m ${CONFMODE} blfs/units/nfs-server.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/rpc-mountd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/proc-fs-nfsd.mount ${UNITSDIR}/

install-nfsv4-server: install-nfs-server
	install -m ${CONFMODE} blfs/units/rpc-idmapd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/var-lib-nfs-rpc_pipefs.mount ${UNITSDIR}/

install-ntpd: create-dirs
	install -m ${CONFMODE} blfs/units/ntpd.service ${UNITSDIR}/
	install -d -m ${DIRMODE} ${DESTDIR}/usr/lib/systemd/ntp-units.d

install-php-fpm: create-dirs
	install -m ${CONFMODE} blfs/units/php-fpm.service ${UNITSDIR}/

install-postfix: create-dirs
	install -m ${CONFMODE} blfs/units/postfix.service ${UNITSDIR}/

install-postgresql: create-dirs
	install -m ${CONFMODE} blfs/tmpfiles/postgresql.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/postgresql.service ${UNITSDIR}/
	systemd-tmpfiles --create postgresql.conf

install-proftpd: create-dirs
	install -m ${CONFMODE} blfs/units/proftpd.service ${UNITSDIR}/

install-rsyncd: create-dirs
	install -m ${CONFMODE} blfs/units/rsyncd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/rsyncdat.service ${UNITSDIR}/rsyncd@.service
	install -m ${CONFMODE} blfs/units/rsyncd.socket ${UNITSDIR}/

install-saslauthd: create-dirs
	install -m ${CONFMODE} blfs/default/saslauthd ${DEFAULTSDIR}/
	install -m ${CONFMODE} blfs/tmpfiles/saslauthd.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/saslauthd.service ${UNITSDIR}/
	systemd-tmpfiles --create saslauthd.conf

install-slapd: create-dirs
	install -m ${CONFMODE} blfs/default/slapd ${DEFAULTSDIR}/
	install -m ${CONFMODE} blfs/tmpfiles/slapd.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/slapd.service ${UNITSDIR}/
	systemd-tmpfiles --create slapd.conf

install-sshd: create-dirs
	install -m ${CONFMODE} blfs/units/sshd.service ${UNITSDIR}/
	install -m ${CONFMODE} blfs/units/sshdat.service ${UNITSDIR}/sshd@.service
	install -m ${CONFMODE} blfs/units/sshd.socket ${UNITSDIR}/

install-sysmond: create-dirs
	install -m ${CONFMODE} blfs/units/sysmond.service ${UNITSDIR}/

install-svnserve: create-dirs
	install -m ${CONFMODE} blfs/default/svnserve ${DEFAULTSDIR}/
	install -m ${CONFMODE} blfs/tmpfiles/svnserve.conf ${TMPFILESDIR}/
	install -m ${CONFMODE} blfs/units/svnserve.service ${UNITSDIR}/
	systemd-tmpfiles --create svnserve.conf

install-unbound: create-dirs
	install -m ${CONFMODE} blfs/units/unbound.service ${UNITSDIR}/

uninstall-acpid:
	test -n "${DESTDIR}" || systemctl stop acpid.service
	test -n "${DESTDIR}" || systemctl disable acpid.socket
	rm -f ${UNITSDIR}/acpid.service ${UNITSDIR}/acpid.socket

uninstall-exim:
	test -n "${DESTDIR}" || systemctl stop exim.service
	test -n "${DESTDIR}" || systemctl disable exim.service
	rm -f ${UNITSDIR}/exim.service

uninstall-git-daemon:
	test -n "${DESTDIR}" || systemctl stop git-daemon
	test -n "${DESTDIR}" || systemctl disable git-daemon
	rm -f ${UNITSDIR}/git-daemon.service

uninstall-gpm:
	test -n "${DESTDIR}" || systemctl stop gpm.service
	test -n "${DESTDIR}" || systemctl disable gpm.service
	rm -f ${UNITSDIR}/gpm.service

uninstall-httpd:
	test -n "${DESTDIR}" || systemctl stop httpd.service
	test -n "${DESTDIR}" || systemctl disable httpd.service
	rm -f ${TMPFILESDIR}/httpd.conf ${UNITSDIR}/httpd.service

uninstall-iptables:
	test -n "${DESTDIR}" || systemctl stop iptables.service
	test -n "${DESTDIR}" || systemctl disable iptables.service
	rm -f ${UNITSDIR}/iptables.service

uninstall-kea-dhcpd:
	test -n "${DESTDIR}" || systemctl stop kea-dhcp.service
	test -n "${DESTDIR}" || systemctl disable kea-dhcp.service
	rm -f ${UNITSDIR}/kea-*
	rm -f ${TMPFILESDIR}/kea.conf

uninstall-krb5:
	test -n "${DESTDIR}" || systemctl stop krb5-kadmind.service
	test -n "${DESTDIR}" || systemctl stop krb5-kpropd.service
	test -n "${DESTDIR}" || systemctl stop krb5-kdc.service
	test -n "${DESTDIR}" || systemctl disable krb5-kadmind.service
	test -n "${DESTDIR}" || systemctl disable krb5-kpropd.service
	test -n "${DESTDIR}" || systemctl disable krb5-kdc.service
	rm -f ${UNITSDIR}/krb5-kadmind.service ${UNITSDIR}/krb5-kpropd.service ${UNITSDIR}/krb5-kdc.service

uninstall-lightdm:
	test -n "${DESTDIR}" || systemctl stop lightdm.service
	test -n "${DESTDIR}" || systemctl disable lightdm.service
	rm -f ${UNITSDIR}/lightdm.service

uninstall-mariadb:
	test -n "${DESTDIR}" || systemctl stop mariadb.service
	test -n "${DESTDIR}" || systemctl disable mariadb.service
	rm -f ${TMPFILESDIR}/mariadb.conf ${UNITSDIR}/mariadb.service

uninstall-named:
	test -n "${DESTDIR}" || systemctl stop named.service
	test -n "${DESTDIR}" || systemctl disable named.service
	rm -f ${TMPFILESDIR}/named.conf ${UNITSDIR}/named.service

uninstall-nfs-client: uninstall-nfs-server
	test -n "${DESTDIR}" || systemctl stop nfs-client.target
	test -n "${DESTDIR}" || systemctl disable nfs-client.target
	rm -f ${DEFAULTSDIR}/nfs-utils ${UNITSDIR}/nfs-client.target
	rm -f ${UNITSDIR}/nfs-client.service ${UNITSDIR}/rpc-statd.service ${UNITSDIR}/rpc-statd-notify.service

uninstall-nfs-server: uninstall-nfsv4-server
	if [[ -z "${DESTDIR}" ]]; then test -e "${UNITSDIR}/nfs-server.service" && systemctl stop nfs-server.service; fi
	if [[ -z "${DESTDIR}" ]]; then test -e "${UNITSDIR}/nfs-server.service" && systemctl disable nfs-server.service; fi
	rm -f ${UNITSDIR}/nfs-server.service ${UNITSDIR}/rpc-mountd.service
	rm -f ${UNITSDIR}/proc-fs-nfsd.mount

uninstall-nfsv4-server:
	rm -f ${UNITSDIR}/rpc-idmapd.service
	rm -f ${UNITSDIR}/var-lib-nfs-rpc_pipefs.mount

uninstall-ntpd:
	test -n "${DESTDIR}" || systemctl stop ntpd.service
	test -n "${DESTDIR}" || systemctl disable ntpd.service
	rm -f ${UNITSDIR}/ntpd.service

uninstall-php-fpm:
	test -n "${DESTDIR}" || systemctl stop php-fpm.service
	test -n "${DESTDIR}" || systemctl disable php-fpm.service
	rm -f ${UNITSDIR}/php-fpm.service

uninstall-postfix:
	test -n "${DESTDIR}" || systemctl stop postfix.service
	test -n "${DESTDIR}" || systemctl disable postfix.service
	rm -f ${UNITSDIR}/postfix.service

uninstall-postgresql:
	test -n "${DESTDIR}" || systemctl stop postgresql.service
	test -n "${DESTDIR}" || systemctl disable postgresql.service
	rm -f ${TMPFILESDIR}/postgresql.conf ${UNITSDIR}/postgresql.service

uninstall-proftpd:
	test -n "${DESTDIR}" || systemctl stop proftpd.service
	test -n "${DESTDIR}" || systemctl disable proftpd.service
	rm -f ${UNITSDIR}/proftpd.service

uninstall-rsyncd:
	test -n "${DESTDIR}" || systemctl stop rsyncd.socket
	test -n "${DESTDIR}" || systemctl stop rsyncd.service
	rm -f ${UNITSDIR}/rsyncd.service ${UNITSDIR}/rsyncd@.service
	rm -f ${UNITSDIR}/rsyncd.socket

uninstall-saslauthd:
	test -n "${DESTDIR}" || systemctl stop saslauthd.service
	test -n "${DESTDIR}" || systemctl disable saslauthd.service
	rm -f ${DEFAULTSDIR}/saslauthd ${TMPFILESDIR}/saslauthd.conf ${UNITSDIR}/saslauthd.service

uninstall-slapd:
	test -n "${DESTDIR}" || systemctl stop slapd.service
	test -n "${DESTDIR}" || systemctl disable slapd.service
	rm -f ${DEFAULTSDIR}/slapd ${TMPFILESDIR}/slapd.conf ${UNITSDIR}/slapd.service

uninstall-sshd:
	test -n "${DESTDIR}" || systemctl stop sshd.socket
	test -n "${DESTDIR}" || systemctl stop sshd.service
	test -n "${DESTDIR}" || systemctl disable sshd.socket
	test -n "${DESTDIR}" || systemctl disable sshd.service
	rm -f ${UNITSDIR}/sshd.service ${UNITSDIR}/sshd@.service ${UNITSDIR}/sshd.socket

uninstall-svnserve:
	test -n "${DESTDIR}" || systemctl stop svnserve.service
	test -n "${DESTDIR}" || systemctl disable svnserve.service
	rm -f ${DEFAULTSDIR}/svnserve ${TMPFILESDIR}/svnserve.conf ${UNITSDIR}/svnserve.service

uninstall-sysmond:
	test -n "${DESTDIR}" || systemctl stop sysmond.service
	test -n "${DESTDIR}" || systemctl disable sysmond.service
	rm -f ${UNITSDIR}/sysmondd.service

uninstall-unbound:
	test -n "${DESTDIR}" || systemctl stop unbound.service
	test -n "${DESTDIR}" || systemctl disable unbound.service
	rm -f ${UNITSDIR}/unbound.service

.PHONY: all create-dirs create-service-dir \
	install-acpid \
	install-exim \
	install-git-daemon \
	install-gpm \
	install-httpd \
	install-iptables \
	install-kea \
	install-krb5 \
	install-mariadb \
	install-named \
	install-nfs-client \
	install-nfs-server \
	install-nfsv4-server \
	install-ntp \
	install-php-fpm \
	install-postfix \
	install-postgresql \
	install-proftpd \
	install-rsyncd \
	install-saslauthd \
	install-slapd \
	install-sshd \
	install-svnserve \
	install-sysmond \
	install-unbound \
	uninstall-acpid \
	uninstall-exim \
	uninstall-git-daemon \
	uninstall-gpm \
	uninstall-httpd \
	uninstall-iptables \
	uninstall-kea-dhcpd \
	uninstall-krb5 \
	uninstall-mariadb \
	uninstall-named \
	uninstall-nfs-client \
	uninstall-nfs-server \
	uninstall-nfsv4-server \
	uninstall-ntpd \
	uninstall-php-fpm \
	uninstall-postfix \
	uninstall-postgresql \
	uninstall-proftpd \
	uninstall-rsyncd \
	uninstall-saslauthd \
	uninstall-slapd \
	uninstall-sshd \
	uninstall-svnserve \
	uninstall-sysmond \
	uninstall-unbound \
