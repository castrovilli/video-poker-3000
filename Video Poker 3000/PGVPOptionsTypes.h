/*
 *  PGVPOptionTypes.h
 *  ===================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Enumeration types for video poker game options.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


/**
 Enumeration type for payout option.
 */
enum PayoutChoiceOptions : int {
    PAYOUT_CHOICE_NORMAL,               /**< Normal payout ratios. */
    PAYOUT_CHOICE_EASY                  /**< Easy (higher) payout ratios. */
};

/**
 Enumeration type for choice of card back images.
 */
enum CardBacksChoiceOptions : int {
    CARDBACKS_CHOICE_BLUE,              /**< Blue card back image. */
    CARDBACKS_CHOICE_RED                /**< Red card back image. */
};
