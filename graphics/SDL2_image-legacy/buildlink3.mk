# $NetBSD: buildlink3.mk,v 1.1 2024/05/06 18:05:31 nia Exp $

BUILDLINK_TREE+=	SDL2_image

.if !defined(SDL2_IMAGE_BUILDLINK3_MK)
SDL2_IMAGE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.SDL2_image+=	SDL2_image>=2.0.0
BUILDLINK_ABI_DEPENDS.SDL2_image+=	SDL2_image>=2.0.0
BUILDLINK_PKGSRCDIR.SDL2_image?=	../../graphics/SDL2_image-legacy
BUILDLINK_INCDIRS.SDL2_image?=		include/SDL2

.include "../../devel/SDL2/buildlink3.mk"
.endif # SDL2_IMAGE_BUILDLINK3_MK

BUILDLINK_TREE+=	-SDL2_image
