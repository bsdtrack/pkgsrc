# $NetBSD: options.mk,v 1.2 2024/08/25 06:19:14 wiz Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.bareos
PKG_SUPPORTED_OPTIONS=		scsi-crypto
PKG_OPTIONS_REQUIRED_GROUPS=	database
PKG_OPTIONS_GROUP.database=	catalog-sqlite3 catalog-pgsql catalog-mysql
PKG_SUGGESTED_OPTIONS=		catalog-pgsql

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mcatalog-sqlite3)
.  include "../../databases/sqlite3/buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=		-Dsqlite3=yes
.elif !empty(PKG_OPTIONS:Mcatalog-pgsql)
.  include "../../mk/pgsql.buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=		-Dpostgresql=yes
.elif !empty(PKG_OPTIONS:Mcatalog-mysql)
.  include "../../mk/mysql.buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=		-Dmysql=yes
.endif

.if !empty(PKG_OPTIONS:Mscsi-crypto)
CMAKE_CONFIGURE_ARGS+=	-Dscsi-crypto=yes
.endif
