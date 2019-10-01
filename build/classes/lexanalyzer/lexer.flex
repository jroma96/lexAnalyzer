package lexanalyzer;
import static lexanalyzer.Tokens.*;
%%
%class Lexer
%column
%line
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
coma=","
operador = "+"|"-"|"/"|"*"|"%"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"||"|"!"|";"|","|"."|"["|"]"|"("|")"|"{"|"}"|"[]"|"()"|"{}"|"@"|"#"|"##"
espacio=[ \s]+
errorComentario = "/*"[^"*/"]*
comentarioM=(("/")("*")([^"/*"])*("*")("/"))
comentarioU=\-\-[^\n]*
Entero = \^[\-\+]?\d+
float = [\-\+]?[0-9]+\.?[0-9]*([eE][\-\+]?[0-9]+)?
cadenaD = (\")[^\"]*(\")
cadenaU = (\')[^\']*(\')
bool = (1|0|NULL)
palabrasReservadas = ("ADD"|"ALL"|"ALTER"|"AND"|"ANY"|"AS"|"ASC"|"AUTHORIZATION"|"BACKUP"|
                     "BEGIN"|"BETWEEN"|"BREAK"|"BROWSE"|"BULK"|"BY"|"CASCADE"|"CASE"|"CHECK"|
                     "CHECKPOINT"|"CLOSE"|"CLUSTERED"|"COALESCE"|"COLLATE"|"COLUMN"|"COMMIT"|
                     "COMPUTE"|"CONSTRAINT"|"CONTAINS"|"CONTAINSTABLE"|"CONTINUE"|"CONVERT"|"CREATE"|
                     "CROSS"|"CURRENT"|"CURRENT_DATE"|"CURRENT_TIME"|"CURRENT_TIMESTAMP"|"CURRENT_USER"|
                     "CURSOR"|"DATABASE"|"DBCC"|"DEALLOCATE"|"DECLARE"|"DEFAULT"|"DELETE"|"DENY"|"DESC"|
                     "DISK"|"DISTINCT"|"DISTRIBUTED"|"DOUBLE"|"DROP"|"DUMP"|"ELSE"|"END"|"ERRLVL"|"ESCAPE"|
                     "EXCEPT"|"EXEC"|"EXECUTE"|"EXISTS"|"EXIT"|"EXTERNAL"|"FETCH"|"FILE"|"FILLFACTOR"|"FOR"|
                     "FOREIGN"|"FREETEXT"|"FREETEXTTABLE"|"FROM"|"FULL"|"FUNCTION"|"GOTO"|"GRANT"|"GROUP"|
                     "HAVING"|"HOLDLOCK"|"IDENTITY"|"IDENTITY_INSERT"|"IDENTITYCOL"|"IF"|"IN"|"INDEX"|
                     "INNER"|"INSERT"|"INTERSECT"|"INTO"|"IS"|"JOIN"|"KEY"|"KILL"|"LEFT"|"LIKE"|"LINENO"|
                     "LOAD"|"MERGE"|"NATIONAL"|"NOCHECK"|"NONCLUSTERED"|"NOT"|"NULL"|"NULLIF"|"OF"|"OFF"|
                     "OFFSETS"|"ON"|"OPEN"|"OPENDATASOURCE"|"OPENQUERY"|"OPENROWSET"|"OPENROWSET"|"OPTION"|
                     "OR"|"ORDER"|"OUTER"|"OVER"|"PERCENT"|"PIVOT"|"PLAN"|"PRECISION"|"PRIMARY"|"PRINT"|
                     "PROC"|"PROCEDURE"|"PUBLIC"|"RAISERROR"|"READ"|"READTEXT"|"RECONFIGURE"|"REFERENCES"|
                     "REPLICATION"|"RESTORE"|"RESTRICT"|"RETURN"|"REVERT"|"REVOKE"|"RIGHT"|"ROLLBACK"|"ROWCOUNT"|
                     "ROWGUIDCOL"|"RULE"|"SAVE"|"SCHEMA"|"SECURITYAUDIT"|"SELECT"|"SEMANTICKEYPHRASETABLE"|
                     "SEMANTICSIMILARITYDETAILSTABLE"|"SEMANTICSIMILARITYTABLE"|"SESSION_USER"|"SET"|"SETUSER"|
                     "SHUTDOWN"|"SOME"|"STATISTICS"|"SYSTEM_USER"|"TABLE"|"TABLESAMPLE"|"TEXTSIZE"|"THEN"|
                     "TO"|"TOP"|"TRAN"|"TRANSACTION"|"TRIGGER"|"TRUNCATE"|"TRY_CONVERT"|"TSEQUAL"|"UNION"|
                     "UNIQUE"|"UNPIVOT"|"UPDATE"|"UPDATETEXT"|"USE"|"USER"|"VALUES"|"VARYING"|"VIEW"|
                     "WAITFOR"|"WHEN"|"WHERE"|"WHILE"|"WITH"|"WITHIN GROUP"|"WRITETEXT"|"ABSOLUTE"|"ACTION"|
                     "ADA"|"ALLOCATE"|"ARE"|"ASSERTION"|"AT"|"AVG"|"BIT"|"BIT_LENGTH"|"BOTH"|"CASCADED"|
                     "CAST"|"CATALOG"|"CHAR"|"CHAR_LENGTH"|"CHARACTER"|"CHARACTER_LENGTH"|"COLLATION"|
                     "CONNECT"|"CONNECTION"|"CONSTRAINTS"|"CORRESPONDING"|"COUNT"|"DATE"|"DAY"|"DEC"|"DECIMAL"|
                     "DEFERRABLE"|"DEFERRED"|"DESCRIBE"|"DESCRIPTOR"|"DIAGNOSTICS"|"DISCONNECT"|"DOMAIN"|
                     "END-EXEC"|"EXCEPTION"|"EXTRACT"|"FALSO"|"FIRST"|"FLOAT"|"FORTRAN"|"FOUND"|"GET"|
                     "GLOBAL"|"GO"|"HOUR"|"IMMEDIATE"|"INCLUDE"|"INDICATOR"|"INITIALLY"|"INPUT"|
                     "INSENSITIVE"|"INT"|"INTEGER"|"INTERVAL"|"ISOLATION"|"LANGUAGE"|"LAST"|"LEADING"|
                     "LEVEL"|"LOCAL"|"LOWER"|"MATCH"|"MAX"|"MIN"|"MINUTE"|"MODULE"|"MONTH"|"NAMES"|"NATURAL"|
                     "NCHAR"|"NEXT"|"NO"|"NONE"|"NUMERIC"|"OCTET_LENGTH"|"ONLY"|"OUTPUT"|"OVERLAPS"|"PAD"|
                     "PARTIAL"|"PASCAL"|"POSITION"|"PREPARE"|"PRESERVE"|"PRIOR"|"PRIVILEGES"|"REAL"|
                     "RELATIVE"|"ROWS"|"SCROLL"|"SECOND"|"SECTION"|"SESSION"|"SIZE"|"SMALLINT"|"SPACE"|
                     "SQL"|"SQLCA"|"SQLCODE"|"SQLERROR"|"SQLSTATE"|"SQLWARNING"|"SUBSTRING"|"SUM"|
                     "TEMPORARY"|"TIME"|"TIMESTAMP"|"TIMEZONE_HOUR"|"TIMEZONE_MINUTE"|"TRAILING"|"TRANSLATE"|
                     "TRANSLATION"|"TRIM"|"TRUE"|"VERDADERO"|"UNKNOWN"|"UPPER"|"USAGE"|"USING"|"VALUE"|"VARCHAR"|
                     "WHENEVER"|"WORK"|"WRITE"|"YEAR"|"ZONE")

%{
    public String lexeme;
    public int col;
    public int line;
%}
%%
({comentarioU}|{comentarioM}) {/*Ignore*/}
{errorComentario}             {line=yyline; col=yycolumn; lexeme=yytext(); return Comentario_Incompleto;}
{espacio}                     {/*Ignore*/}
{Entero}                      {line=yyline; col=yycolumn; lexeme=yytext(); return Entero;}
{float}                       {line=yyline; col=yycolumn; lexeme=yytext(); return Decimal;}
({cadenaD}|{cadenaU})         {line=yyline; col=yycolumn; lexeme=yytext(); return String;}
{bool}                        {line=yyline; col=yycolumn; lexeme=yytext(); return Boolean;}
{operador}                    {line=yyline; col=yycolumn; lexeme=yytext(); return Operador;}
{palabrasReservadas}          {line=yyline; col=yycolumn; lexeme=yytext(); return Reservadas;}
{L}({L}|{D})*                 {line=yyline; col=yycolumn; lexeme=yytext(); return Identificador;}
{coma}                        {line=yyline; col=yycolumn; lexeme=yytext(); return Coma;}                                                                                          
 .                            {line=yyline; col=yycolumn; lexeme=yytext(); return ERROR;}
