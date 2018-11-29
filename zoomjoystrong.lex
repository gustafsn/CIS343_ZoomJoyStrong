%{
    #include <stdio.h>
    void printLexeme();
%}

%%

END		return END;
;		return END_STATEMENT;
point		return POINT;
line		return LINE;
circle		return CIRCLE;
rectangle	return RECTANGLE;
set_color	return SET_COLOR;
[0-9]+		return INT;
[0-9.]+		return FLOAT;

[ |\t|\n]        ;
.               { printf("you MESSED UP!\t");}

%%
void printLexeme(){
        printf("(%s)\n", yytext);
}

int main(int argc, char** argv){
    yylex();    //start lexing
    return 0;
}
