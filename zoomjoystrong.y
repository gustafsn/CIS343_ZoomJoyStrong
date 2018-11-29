%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	#define YYSTYPE int
	int yyerror(const char* err);
	
%}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%%

program:	list_of_statements END END_STATEMENT
	;

list_of_statements:	
		statement
	|	list_of_statements statement
	;

statement:
		LINE INT INT INT INT END_STATEMENT{
			line($2, $3, $4, $5);
		}
	|	POINT INT INT END_STATEMENT{
			point($2, $3);
		}
	|	CIRCLE INT INT INT END_STATEMENT{
			circle($2, $3, $4);
		}
	|	RECTANGLE INT INT INT INT END_STATEMENT{
			rectangle($2, $3, $4, $5);
		}
	|	SET_COLOR INT INT INT END_STATEMENT{
			set_color($2, $3, $4);
		}
	|	END END_STATEMENT{
			finish();
		}
	;

%%
int yylval;
int lineNum = 1;

int main(int argc, char** argv){
	setup();	
	yyparse();
	
}

int yyerror(const char* err){
	printf("%s\t%d\n", err, lineNum);
}

int yywrap(void) {
    return 1;
}
