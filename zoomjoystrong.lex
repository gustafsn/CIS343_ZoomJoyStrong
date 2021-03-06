%{
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
	#define YYSTYPE int
	extern int yylval;
	extern int lineNum;
%}

%%

end		return END;
;		return END_STATEMENT;
point		return POINT;
line		return LINE;
circle		return CIRCLE;
rectangle	return RECTANGLE;
set_color	return SET_COLOR;
[0-9]+		{
		yylval = atoi(yytext); 
		return INT;
		}
[0-9.]+		{
		yylval = atof(yytext);
		return FLOAT;
		}
\n		{lineNum++;}
[ |\t]	        ;
.               { 
			printf("*INVALID!*\n");
		}

%%
