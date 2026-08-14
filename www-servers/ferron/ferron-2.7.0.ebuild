# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.25.1
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.4
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	android_system_properties@0.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.102
	arc-swap@1.9.0
	argon2@0.5.3
	arraydeque@0.5.1
	asn1-rs-derive@0.6.0
	asn1-rs-impl@0.2.0
	asn1-rs@0.7.1
	async-channel@2.5.0
	async-compression@0.4.41
	async-io@2.6.0
	async-lock@3.4.2
	async-process@2.5.0
	async-signal@0.2.13
	async-task@4.7.1
	async-trait@0.1.89
	atomic-waker@1.1.2
	auto-const-array@0.2.2
	autocfg@1.5.0
	aws-config@1.8.15
	aws-credential-types@1.2.14
	aws-lc-rs@1.16.2
	aws-lc-sys@0.39.0
	aws-runtime@1.7.2
	aws-sdk-route53@1.110.0
	aws-sdk-sts@1.101.0
	aws-sigv4@1.4.2
	aws-smithy-async@1.2.14
	aws-smithy-http-client@1.1.12
	aws-smithy-http@0.63.6
	aws-smithy-json@0.62.5
	aws-smithy-observability@0.2.6
	aws-smithy-query@0.60.15
	aws-smithy-runtime-api@1.11.6
	aws-smithy-runtime@1.10.3
	aws-smithy-types@1.4.7
	aws-smithy-xml@0.60.15
	aws-types@1.3.14
	backtrace-ext@0.2.1
	backtrace@0.3.76
	base64-simd@0.8.0
	base64@0.22.1
	base64ct@1.8.3
	bit-set@0.8.0
	bit-vec@0.8.0
	bitflags@1.3.2
	bitflags@2.11.0
	bitvec-nom2@0.2.1
	bitvec@1.0.1
	blake2@0.10.6
	block-buffer@0.10.4
	blocking@1.6.2
	brotli-decompressor@5.0.0
	brotli@8.0.2
	bstr@1.12.1
	bumpalo@3.20.2
	bytecount@0.6.9
	bytes-utils@0.1.4
	bytes@1.11.1
	cc@1.2.57
	cegla-cgi@0.2.0
	cegla-scgi@0.2.0
	cegla@0.2.0
	cesu8@1.1.0
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	chacha20@0.10.0
	chrono@0.4.44
	cidr@0.3.2
	cipher@0.4.4
	clap@4.6.0
	clap_builder@4.6.0
	clap_derive@4.6.0
	clap_lex@1.1.0
	cmake@0.1.57
	colorchoice@1.0.5
	combine@4.6.7
	compression-codecs@0.4.37
	compression-core@0.4.31
	concurrent-queue@2.5.0
	connpool@0.2.0
	const-hex@1.18.1
	const_format@0.2.35
	const_format_proc_macros@0.2.34
	core-foundation-sys@0.8.7
	core-foundation@0.10.1
	core_affinity@0.8.3
	cpufeatures@0.2.17
	cpufeatures@0.3.0
	crc32fast@1.5.0
	critical-section@1.2.0
	crossbeam-channel@0.5.15
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-queue@0.3.12
	crossbeam-utils@0.8.21
	crypto-common@0.1.7
	data-encoding@2.10.0
	der-parser@10.0.0
	deranged@0.5.8
	digest@0.10.7
	dirs-sys@0.5.0
	dirs@6.0.0
	displaydoc@0.2.5
	document-features@0.2.12
	dunce@1.0.5
	either@1.15.0
	encoding_rs@0.8.35
	endian-type@0.1.2
	enum-as-inner@0.6.1
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fancy-regex@0.17.0
	fastrand@2.3.0
	find-msvc-tools@0.1.9
	flate2@1.1.9
	fnv@1.0.7
	foldhash@0.1.5
	foldhash@0.2.0
	form_urlencoded@1.2.2
	fs_extra@1.3.0
	funty@2.0.0
	futures-channel@0.3.32
	futures-core@0.3.32
	futures-executor@0.3.32
	futures-io@0.3.32
	futures-lite@2.6.1
	futures-macro@0.3.32
	futures-sink@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	futures@0.3.32
	generic-array@0.14.7
	getrandom@0.2.17
	getrandom@0.3.4
	getrandom@0.4.2
	gimli@0.32.3
	glob@0.3.3
	globset@0.4.18
	h2@0.4.13
	h3-quinn@0.0.10
	h3@0.0.8
	hashbrown@0.15.5
	hashbrown@0.16.1
	hashlink@0.11.0
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	hickory-client@0.25.2
	hickory-proto@0.25.2
	hickory-resolver@0.25.2
	hmac@0.12.1
	http-body-util@0.1.3
	http-body@0.4.6
	http-body@1.0.1
	http@0.2.12
	http@1.4.0
	httparse@1.10.1
	httpdate@1.0.3
	hyper-rustls@0.27.7
	hyper-timeout@0.5.2
	hyper-util@0.1.20
	hyper@1.8.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.65
	icu_collections@2.1.1
	icu_locale_core@2.1.1
	icu_normalizer@2.1.1
	icu_normalizer_data@2.1.1
	icu_properties@2.1.2
	icu_properties_data@2.1.2
	icu_provider@2.1.1
	id-arena@2.3.0
	idna@1.1.0
	idna_adapter@1.2.1
	indexmap@2.13.0
	inout@0.1.4
	instant-acme@0.8.5
	io-uring@0.6.4
	ipconfig@0.3.4
	ipnet@2.12.0
	iri-string@0.7.11
	is_ci@1.2.0
	is_debug@1.1.0
	is_terminal_polyfill@1.70.2
	itertools@0.13.0
	itertools@0.14.0
	itoa@1.0.18
	jni-sys-macros@0.4.1
	jni-sys@0.3.1
	jni-sys@0.4.1
	jni@0.21.1
	jobserver@0.1.34
	js-sys@0.3.91
	kanal@0.1.1
	kdl@6.5.0
	lazy_static@1.5.0
	leb128fmt@0.1.0
	libc@0.2.183
	libmimalloc-sys@0.1.44
	libredox@0.1.15
	libtcmalloc-sys@0.1.14
	linux-raw-sys@0.12.1
	litemap@0.8.1
	litrs@1.0.0
	lock_api@0.4.14
	log@0.4.29
	lru-slab@0.1.2
	malloc-best-effort@0.1.4
	memchr@2.8.0
	miette-derive@7.6.0
	miette@7.6.0
	mimalloc@0.1.48
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.1.1
	moka@0.12.15
	monoio-compat@0.2.2
	new_mime_guess@4.0.4
	nibble_vec@0.1.0
	nix@0.30.1
	nom@7.1.3
	nom_locate@4.2.0
	num-bigint@0.4.6
	num-complex@0.4.6
	num-conv@0.2.1
	num-integer@0.1.46
	num-iter@0.1.45
	num-rational@0.4.2
	num-traits@0.2.19
	num@0.4.3
	num_cpus@1.17.0
	num_threads@0.1.7
	object@0.37.3
	oid-registry@0.8.1
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	oneshot@0.2.1
	openssl-probe@0.2.1
	opentelemetry-http@0.31.0
	opentelemetry-otlp@0.31.1
	opentelemetry-proto@0.31.0
	opentelemetry@0.31.0
	opentelemetry_sdk@0.31.0
	option-ext@0.2.0
	outref@0.5.2
	owo-colors@4.3.0
	parking@2.2.1
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	password-auth@1.0.0
	password-hash@0.5.0
	patch@0.7.0
	pbkdf2@0.12.2
	pem@3.0.6
	percent-encoding@2.3.2
	pin-project-internal@1.1.11
	pin-project-lite@0.2.17
	pin-project@1.1.11
	pin-utils@0.1.0
	piper@0.2.5
	pkg-config@0.3.32
	polling@3.11.0
	portable-atomic@1.13.1
	potential_utf@0.1.4
	powerfmt@0.2.0
	ppp@2.3.0
	ppv-lite86@0.2.21
	prettyplease@0.2.37
	proc-macro2@1.0.106
	procfs-core@0.18.0
	procfs@0.18.0
	proptest@1.11.0
	prost-derive@0.14.3
	prost@0.14.3
	quick_cache@0.6.21
	quinn-proto@0.11.14
	quinn-udp@0.5.14
	quinn@0.11.9
	quote@1.0.45
	r-efi@5.3.0
	r-efi@6.0.0
	radium@0.7.0
	radix_trie@0.2.1
	rand@0.10.0
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.10.0
	rand_core@0.6.4
	rand_core@0.9.5
	rand_xorshift@0.4.0
	rasn-derive-impl@0.28.10
	rasn-derive@0.28.10
	rasn-ocsp@0.28.10
	rasn-pkix@0.28.10
	rasn@0.28.10
	rayon-core@1.13.0
	rayon@1.11.0
	rcgen@0.14.7
	redox_syscall@0.5.18
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-lite@0.1.9
	regex-syntax@0.8.10
	regex@1.12.3
	regorus@0.9.1
	reqwest@0.13.2
	resolv-conf@0.7.6
	reusable-box-future@0.2.0
	ring@0.17.14
	rpassword@7.4.0
	rtoolbox@0.0.3
	rustc-demangle@0.1.27
	rustc-hash@2.1.1
	rustc_version@0.4.1
	rusticata-macros@4.1.0
	rustix@1.1.4
	rustls-native-certs@0.8.3
	rustls-pki-types@1.14.0
	rustls-platform-verifier-android@0.1.1
	rustls-platform-verifier@0.6.2
	rustls-webpki@0.103.10
	rustls@0.23.37
	rustversion@1.0.22
	rusty_pool@0.7.0
	ryu@1.0.23
	salsa20@0.10.2
	same-file@1.0.6
	schannel@0.1.29
	scopeguard@1.2.0
	scrypt@0.11.0
	security-framework-sys@2.17.0
	security-framework@3.7.0
	semver@1.0.27
	send_wrapper@0.6.0
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_spanned@1.1.0
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.9
	shadow-rs@1.7.1
	shiba@0.1.1
	shlex@1.3.0
	signal-hook-registry@1.4.8
	simd-adler32@0.3.8
	slab@0.4.12
	smallvec@1.15.1
	snafu-derive@0.8.9
	snafu@0.8.9
	socket2@0.6.3
	spin@0.9.8
	stable_deref_trait@1.2.1
	strsim@0.11.1
	strum@0.27.2
	strum_macros@0.27.2
	subtle@2.6.1
	supports-color@3.0.2
	supports-hyperlinks@3.2.0
	supports-unicode@3.0.0
	syn@2.0.117
	sync_wrapper@1.0.2
	synstructure@0.13.2
	tagptr@0.2.0
	tap@1.0.1
	tcmalloc-better@0.1.19
	tempfile@3.27.0
	terminal_size@0.4.4
	textwrap@0.16.2
	thiserror-impl@1.0.69
	thiserror-impl@2.0.18
	thiserror@1.0.69
	thiserror@2.0.18
	threadpool@1.8.1
	time-core@0.1.8
	time-macros@0.2.27
	time@0.3.47
	tinystr@0.8.2
	tinyvec@1.11.0
	tinyvec_macros@0.1.1
	tokenbucket@0.1.6
	tokio-cegla@0.2.0
	tokio-macros@2.6.1
	tokio-rustls@0.26.4
	tokio-stream@0.1.18
	tokio-util@0.7.18
	tokio@1.50.0
	toml@1.1.0+spec-1.1.0
	toml_datetime@1.1.0+spec-1.1.0
	toml_parser@1.1.0+spec-1.1.0
	toml_writer@1.1.0+spec-1.1.0
	tonic-prost@0.14.5
	tonic@0.14.5
	tower-http@0.6.8
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.5.3
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing@0.1.44
	try-lock@0.2.5
	typenum@1.19.0
	tz-rs@0.7.3
	tzdb@0.7.3
	tzdb_data@0.2.4
	unarray@0.1.4
	unicase@2.9.0
	unicode-ident@1.0.24
	unicode-linebreak@0.1.5
	unicode-width@0.1.14
	unicode-width@0.2.2
	unicode-xid@0.2.6
	untrusted@0.7.1
	untrusted@0.9.0
	url@2.5.8
	urlencoding@2.1.3
	utf8_iter@1.0.4
	utf8parse@0.2.2
	uuid@1.22.0
	version_check@0.9.5
	vibeio-http@0.3.0
	vibeio-hyper@0.2.6
	vibeio@0.2.6
	vsimd@0.8.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-futures@0.4.64
	wasm-bindgen-macro-support@0.2.114
	wasm-bindgen-macro@0.2.114
	wasm-bindgen-shared@0.2.114
	wasm-bindgen@0.2.114
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	web-sys@0.3.91
	web-time@1.1.0
	webpki-root-certs@1.0.6
	webpki-roots@1.0.6
	widestring@1.2.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.62.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-registry@0.6.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.5
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.1
	winnow@0.6.24
	winnow@1.0.0
	winresource@0.1.31
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	writeable@0.6.2
	wyz@0.5.1
	x509-parser@0.18.1
	xml-no-std@0.8.26
	xmlparser@0.13.6
	xxhash-rust@0.8.15
	yaml-rust2@0.11.0
	yasna@0.5.2
	yoke-derive@0.8.1
	yoke@0.8.1
	zerocopy-derive@0.8.47
	zerocopy@0.8.47
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.2
	zerotrie@0.2.3
	zerovec-derive@0.11.2
	zerovec@0.11.5
	zlib-rs@0.6.3
	zmij@1.0.21
	zstd-safe@7.2.4
	zstd-sys@2.0.16+zstd.1.5.7
	zstd@0.13.3
"

declare -A GIT_CRATES=(
	[monoio]="https://github.com/DorianNiemiecSVRJS/monoio;7955c1356585d7ebd45d67f5932620c09ac0a701;monoio-%commit%/monoio"
	[monoio-compat]="https://github.com/DorianNiemiecSVRJS/monoio;7955c1356585d7ebd45d67f5932620c09ac0a701;monoio-%commit%/monoio-compat"
	[monoio-macros]="https://github.com/DorianNiemiecSVRJS/monoio;7955c1356585d7ebd45d67f5932620c09ac0a701;monoio-%commit%/monoio-macros"
	[dns-update]="https://github.com/stalwartlabs/dns-update;af7f09050f7b80bfda9f8b4c95e97121eab250ff"
)

inherit cargo systemd

DESCRIPTION="A fast, modern, and easily configurable web server with automatic TLS"
HOMEPAGE="https://ferron.sh"
SRC_URI="https://github.com/ferronweb/ferron/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT
	Apache-2.0 BSD Boost-1.0 CDLA-Permissive-2.0 ISC MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd +tokio"

BDEPEND="
	dev-build/cmake
	dev-lang/nasm
	sys-libs/libcap
"
RDEPEND="
	acct-user/ferron
	acct-group/ferron
"

QA_FLAGS_IGNORED="/usr/sbin/ferron"

src_prepare() {
	default

	sed -i '/^\[patch\./,$d' "${S}/Cargo.toml"

	cat >> "${S}/Cargo.toml" <<-EOF

	[patch.crates-io]
	monoio = { path = "${WORKDIR}/monoio-7955c1356585d7ebd45d67f5932620c09ac0a701/monoio" }
	monoio-compat = { path = "${WORKDIR}/monoio-7955c1356585d7ebd45d67f5932620c09ac0a701/monoio-compat" }
	monoio-macros = { path = "${WORKDIR}/monoio-7955c1356585d7ebd45d67f5932620c09ac0a701/monoio-macros" }
	dns-update = { path = "${WORKDIR}/dns-update-af7f09050f7b80bfda9f8b4c95e97121eab250ff" }

	[patch.'https://github.com/ferronweb/ferron']
	ferron-common = { path = "./ferron-common" }
	EOF
}

src_configure() {
	local myfeatures=(
		config-yaml-legacy
		$(usev tokio ferron/runtime-tokio)
		$(usev !tokio runtime-monoio)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install --path ferron

	insinto /usr/share/ferron
	doins configs/ferron.packages.kdl
	newins configs/ferron.packages.kdl ferron.kdl.example

	insinto /usr/share/ferron/wwwroot
	doins -r wwwroot/*

	newinitd "${FILESDIR}/ferron.initd" ferron
	newconfd "${FILESDIR}/ferron.confd" ferron

	if use systemd; then
		systemd_dounit "${FILESDIR}/ferron.service"
	fi
}

pkg_postinst() {
	setcap cap_net_bind_service=+ep /usr/sbin/ferron || \
		ewarn "Failed to set capabilities on /usr/sbin/ferron"

	elog
	elog "Ferron has been installed. To get started:"
	elog
	elog "  1. Copy the example configuration to /etc/ferron.kdl:"
	elog "     cp /usr/share/ferron/ferron.kdl.example /etc/ferron.kdl"
	elog
	elog "  2. Edit the configuration to suit your needs."
	elog
	elog "  3. Start the service:"
	if use systemd; then
		elog "     systemctl start ferron"
	else
		elog "     rc-service ferron start"
	fi
	elog
}
