%[
    #include std.io
    void printLexeme();
%]

%%

END             { printf("END\t"); printLexeme();}
END_STATEMENT   { printf("END_STATEMENT\t"); printLexeme();}
POINT           { printf("POINT\t"); printLexeme();}
LINE            { printf("LINE\t"); printLexeme();}
CIRCLE          { printf("CIRCLE\t"); printLexeme();}
RECTANGLE       { printf("RECTANGLE\t"); printLexeme();}
SET_COLOR       { printf("SET_COLOR\t"); printLexeme();}
INT             { printf("INT\t"); printLexeme();}
FLOAT           { printf("FLOAT\t"); printLexeme();}

\T|[ ]|\n        ;
.               { printf("you MESSED UP!\t"); printLexeme();}

%%
void printLexeme(){
        printf("(%s)\n", yytext);
}

int main(int argc, char** argv){
    yylex();    //start lexing
    return0;
}
