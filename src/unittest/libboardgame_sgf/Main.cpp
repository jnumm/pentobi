//-----------------------------------------------------------------------------
/** @file unittest/libboardgame_sgf/Main.cpp */
//-----------------------------------------------------------------------------

#include "libboardgame_test/Test.h"

//-----------------------------------------------------------------------------

int main(int, char**)
{
    if (libboardgame_test::run_all_tests())
        return 0;
    else
        return 1;
}

//----------------------------------------------------------------------------
