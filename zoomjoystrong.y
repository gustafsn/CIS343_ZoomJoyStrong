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
			/*draws a line from (x,y) to (u,v)*/
			if($2>=0 && $2<=WIDTH &&
			   $4>=0 && $4<=WIDTH &&
			   $3>=0 && $3<=HEIGHT &&
			   $5>=0 && $5<=HEIGHT){
				line($2, $3, $4, $5);
			}
			else{
				printf("INPUT ERROR: line x y u v -- 0<=x,u<=%d and 0<=y,v<=%d", WIDTH, HEIGHT);
			}
		}
	|	POINT INT INT END_STATEMENT{
			/*draws a point at (x,y)*/
			if($2>=0 && $2<=WIDTH &&
			   $3>=0 && $3<=HEIGHT){
				point($2, $3);
			}
			else{
				printf("INPUT ERROR: point x y -- 0<=x<=%d and 0<=y<=%d", WIDTH, HEIGHT);
			}
		}
	|	CIRCLE INT INT INT END_STATEMENT{
			/*draws circle at (x,y) with radius r*/
			if($2>=0 && $2<=WIDTH &&
			   $3>=0 && $3<=HEIGHT &&
			   $4>0 &&
			  ($2-$4)>=0 && ($2+$4)<=WIDTH &&
			  ($3-$4)>=0 && ($3+$4)<=HEIGHT){
				circle($2, $3, $4);
			}
			else{
				printf("INPUT ERROR: circle x y r -- 0<=x<=%d and 0<=y<=%d, r is pos., -+r and xy must stay within bounds as well", WIDTH, HEIGHT);
			}
		}
	|	RECTANGLE INT INT INT INT END_STATEMENT{
			
			/*draws rectangle (x,y) from top left with height h and width w*/
			if($2>=0 && $2<=WIDTH &&
			   $3>=0 && $3<=HEIGHT &&
			   $4>0 && $5>0 &&
		   	  ($2+$4)<=WIDTH  &&  ($3+$5)<=HEIGHT){
				rectangle($2, $3, $4, $5);
			}
			else{
				printf("INPUT ERROR: circle x y w h -- 0<=x<=%d and 0<=y<=%d, w&h are pos., (x+w) and (y+h) must stay within bounds as well", WIDTH, HEIGHT);
			}
		}
	|	SET_COLOR INT INT INT END_STATEMENT{
			/*changes the current drawing color to the r,g,b tuple*/
			if($2>=0 && $2<=255 &&
			   $3>=0 && $3<=255 &&
			   $4>=0 && $4<=255){
				set_color($2, $3, $4);
			}
			else{
				printf("INPUT ERROR: set_color r g b -- 0<=r,j,g<=255");
			}
		}
	;

%%
int yylval;
int lineNum = 1;

int main(int argc, char** argv){
	setup();	
	yyparse();
	finish();
	
}

int yyerror(const char* err){
	printf("%s\t%d\n", err, lineNum);
}

int yywrap(void) {
    return 1;
}
