# $NetBSD: export-all.mk,v 1.5 2024/09/17 11:52:31 jperkin Exp $

UT_OK=	good
UT_F=	fine

# the old way to do :tA
M_tAbad=	C,.*,cd & \&\& 'pwd',:sh
# the new
M_tA=		tA

here := ${.PARSEDIR}

# this will cause trouble (recursing if we let it)
UT_BADDIR=	${${here}/../${here:T}:L:${M_tAbad}:T}
# this will be ok
UT_OKDIR=	${${here}/../${here:T}:L:${M_tA}:T}

.export-all

FILTER_CMD=	grep ^UT_
.include "export.mk"

UT_TEST=	export-all
UT_ALL=		even this gets exported
