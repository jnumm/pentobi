//-----------------------------------------------------------------------------
/** @file libpentobi_base/PieceTransformsTrigon.h */
//-----------------------------------------------------------------------------

#ifndef LIBPENTOBI_PIECE_TRANSFORMS_TRIGON_H
#define LIBPENTOBI_PIECE_TRANSFORMS_TRIGON_H

#include "PieceTransforms.h"

namespace libpentobi_base {

using libboardgame_base::TransfIdentity;
using libboardgame_base::TransfTrigonRefl;
using libboardgame_base::TransfTrigonReflRot120;
using libboardgame_base::TransfTrigonReflRot240;
using libboardgame_base::TransfTrigonRot120;
using libboardgame_base::TransfTrigonRot240;

//-----------------------------------------------------------------------------

class PieceTransformsTrigon
    : public PieceTransforms
{
public:
    PieceTransformsTrigon();

    const Transform* get_mirrored_horizontally(const Transform* transf) const;

    const Transform* get_mirrored_vertically(const Transform* transf) const;

    const Transform* get_rotated_anticlockwise(const Transform* transf) const;

    const Transform* get_rotated_clockwise(const Transform* transf) const;

private:
    TransfIdentity m_identity;

    TransfTrigonRot120 m_rot120;

    TransfTrigonRot240 m_rot240;

    TransfTrigonRefl m_refl;

    TransfTrigonReflRot120 m_refl_rot120;

    TransfTrigonReflRot240 m_refl_rot240;
};

//-----------------------------------------------------------------------------

} // namespace libpentobi_base

#endif // LIBPENTOBI_PIECE_TRANSFORMS_TRIGON_H
