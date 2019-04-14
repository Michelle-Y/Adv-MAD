//
//  Alphabet.swift
//  Hush
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import Foundation
class Alphabet {
    let SHIFT_SIZE = 26;
    let ALPHABET_LOWER_CASE = "abcdefghijklmnopqrstuvwxyz";
    let ALPHABET_UPPER_CASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let LETTER_POSITION_MAP = [
        "a" : 0,
        "b" : 1,
        "c" : 2,
        "d" : 3,
        "e" : 4,
        "f" : 5,
        "g" : 6,
        "h" : 7,
        "i" : 8,
        "j" : 9,
        "k" : 10,
        "l" : 11,
        "m" : 12,
        "n" : 13,
        "o" : 14,
        "p" : 15,
        "q" : 16,
        "r" : 17,
        "s" : 18,
        "t" : 19,
        "u" : 20,
        "v" : 21,
        "w" : 22,
        "x" : 23,
        "y" : 24,
        "z" : 25
    ];
    
    func getLetterFromPosition(_ position: Int) -> String {
        return String(ALPHABET_LOWER_CASE[ALPHABET_LOWER_CASE.characters.index(ALPHABET_LOWER_CASE.startIndex, offsetBy: position % SHIFT_SIZE)]);
    };
    
    func getPositionFromLetter(_ letter: String) -> Int {
        return LETTER_POSITION_MAP[letter]!;
    };
}
