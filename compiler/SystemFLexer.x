{
module SystemFLexer (lexSF) where

import SystemFTokens

}

%wrapper "basic"

$alpha = [A-Za-z]
$digit = [0-9]

tokens :-

    $white+     ;

    \/\\        { \_ -> TokenTLambda }
    \\          { \_ -> TokenLambda }
    fix         { \_ -> TokenFix }
    \,          { \_ -> TokenComma }
    \.          { \_ -> TokenDot }
    \-\>        { \_ -> TokenArrow }
    \:          { \_ -> TokenColon }
    let         { \_ -> TokenLet }
    \=          { \_ -> TokenEQ }
    in          { \_ -> TokenIn }
    \(          { \_ -> TokenOParen }
    \)          { \_ -> TokenCParen }
    forall      { \_ -> TokenForall }
    Int         { \_ -> TokenIntType }
    if0         { \_ -> TokenIf0 }
    then        { \_ -> TokenThen }
    else        { \_ -> TokenElse }

    [a-z] [$alpha $digit \_ \']*  { \s -> TokenLowId s }
    [A-Z] [$alpha $digit \_ \']*  { \s -> TokenUpId s }

    $digit+  { \s -> TokenInt (read s) }

    \_ $digit+ { \s -> TokenTupleField (read (tail s))  }

{
lexSF :: String -> [SystemFToken]
lexSF = alexScanTokens
}
