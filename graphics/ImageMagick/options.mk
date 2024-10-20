# $NetBSD: options.mk,v 1.28 2024/07/11 19:45:12 wiz Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.ImageMagick
PKG_SUPPORTED_OPTIONS=		djvu doc fontconfig fpx ghostscript heif jp2
PKG_SUPPORTED_OPTIONS+=		liblqr openexr raqm tiff wmf x11
PKG_OPTIONS_REQUIRED_GROUPS=	policy
PKG_OPTIONS_GROUP.policy=	imagemagick-policy-limited imagemagick-policy-open imagemagick-policy-secure imagemagick-policy-websafe
PKG_SUGGESTED_OPTIONS=		doc fontconfig ghostscript heif jp2 liblqr raqm tiff x11 imagemagick-policy-open

.include "../../mk/bsd.options.mk"

PLIST_SRC+=		PLIST

.if !empty(PKG_OPTIONS:Mdoc)
PLIST_SRC+=		PLIST.doc
.else
CONFIGURE_ARGS+=	--disable-docs
.endif

.if !empty(PKG_OPTIONS:Mfontconfig)
CONFIGURE_ARGS+=	--with-fontconfig
.include "../../fonts/fontconfig/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--without-fontconfig
.endif

.if !empty(PKG_OPTIONS:Mghostscript)
CONFIGURE_ARGS+=	--with-gslib
.include "../../print/ghostscript/buildlink3.mk"
.  if ${PKG_BUILD_OPTIONS.ghostscript:Mghostscript-gpl}
CFLAGS+=		-DPKGSRC_USE_OLD_GHOSTSCRIPT
.  endif
.else
CONFIGURE_ARGS+=	--without-gslib
.endif

.if !empty(PKG_OPTIONS:Mx11)
.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--without-x
.endif

.if !empty(PKG_OPTIONS:Mjp2)
.include "../../graphics/openjpeg/buildlink3.mk"
CONFIGURE_ARGS+=	--with-openjp2
.else
CONFIGURE_ARGS+=	--without-openjp2
.endif

.if !empty(PKG_OPTIONS:Mliblqr)
.include "../../graphics/liblqr/buildlink3.mk"
CONFIGURE_ARGS+=	--with-lqr
.else
CONFIGURE_ARGS+=	--without-lqr
.endif

.if !empty(PKG_OPTIONS:Mdjvu)
.include "../../graphics/djvulibre-lib/buildlink3.mk"
CONFIGURE_ARGS+=	--with-djvu
.else
CONFIGURE_ARGS+=	--without-djvu
.endif

.if !empty(PKG_OPTIONS:Mopenexr)
.include "../../graphics/openexr/buildlink3.mk"
CONFIGURE_ARGS+=	--with-openexr
.else
CONFIGURE_ARGS+=	--without-openexr
.endif

.if !empty(PKG_OPTIONS:Mraqm)
.include "../../graphics/raqm/buildlink3.mk"
CONFIGURE_ARGS+=	--with-raqm
.else
CONFIGURE_ARGS+=	--without-raqm
.endif

.if !empty(PKG_OPTIONS:Mtiff)
.include "../../graphics/tiff/buildlink3.mk"
CONFIGURE_ARGS+=	--with-tiff
.else
CONFIGURE_ARGS+=	--without-tiff
.endif

.if !empty(PKG_OPTIONS:Mwmf)
.include "../../graphics/libwmf/buildlink3.mk"
CONFIGURE_ARGS+=	--with-wmf
.else
CONFIGURE_ARGS+=	--without-wmf
.endif

.if !empty(PKG_OPTIONS:Mheif)
.include "../../graphics/libheif/buildlink3.mk"
CONFIGURE_ARGS+=	--with-heic
.else
CONFIGURE_ARGS+=	--without-heic
.endif

.if !empty(PKG_OPTIONS:Mfpx)
.include "../../graphics/libfpx/buildlink3.mk"
CONFIGURE_ARGS+=	--with-fpx
.else
CONFIGURE_ARGS+=	--without-fpx
.endif

.if !empty(PKG_OPTIONS:Mimagemagick-policy-limited)
CONF_FILES+=		${EGDIR}/policy-limited.xml ${PKG_SYSCONFDIR}/policy.xml
.endif
.if !empty(PKG_OPTIONS:Mimagemagick-policy-open)
CONF_FILES+=		${EGDIR}/policy-open.xml ${PKG_SYSCONFDIR}/policy.xml
.endif
.if !empty(PKG_OPTIONS:Mimagemagick-policy-secure)
CONF_FILES+=		${EGDIR}/policy-secure.xml ${PKG_SYSCONFDIR}/policy.xml
.endif
.if !empty(PKG_OPTIONS:Mimagemagick-policy-websafe)
CONF_FILES+=		${EGDIR}/policy-websafe.xml ${PKG_SYSCONFDIR}/policy.xml
.endif
