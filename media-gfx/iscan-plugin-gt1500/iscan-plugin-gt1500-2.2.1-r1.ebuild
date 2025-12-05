# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit multilib

MY_P="iscan-plugin-gt-1500-$(ver_rs 3 -)"

DESCRIPTION="Epson GT-1500 scanner plugin for SANE 'epkowa' backend."
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="iscan-gt-1500-bundle-2.30.4.x64.deb.tar.gz"

LICENSE="EPSON EAPL"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="minimal"

DEPEND="minimal? ( >=media-gfx/iscan-2.21.0 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_configure() { :; }
src_compile() { :; }

src_unpack() {
    unpack iscan-gt-1500-bundle-2.30.4.x64.deb.tar.gz
    unpack iscan-gt-1500-bundle-2.30.4.x64.deb/plugins/iscan-plugin-gt-1500_2.2.1-1_amd64.deb
	tar xvzf data.tar.gz
}

src_install() {
	# install scanner firmware
	insinto /usr/share/iscan
	doins "${WORKDIR}/usr/share/iscan/"*

	dodoc usr/share/doc/*/*

	use minimal && return
	# install scanner plugins
	exeinto /opt/iscan/esci
	doexe "${WORKDIR}/usr/lib/iscan/"*
	dosym libesint86.so.2 /opt/iscan/esci/libesint86.so.2.so
}

pkg_setup() {
	basecmds=(
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x0133 '/opt/iscan/esci/libesint86.so.2 /usr/share/iscan/esfw86.bin'"
	)
}

pkg_postinst() {
	elog
	elog "Firmware file esfw86.bin for Epson GT-1500"
	elog "has been installed in /usr/share/iscan."
	elog
	use minimal && return
	[[ -n ${REPLACING_VERSIONS} ]] && return

	# Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	use minimal && return
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to de-register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}