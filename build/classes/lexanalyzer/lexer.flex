package lexanalyzer;
import java_cup.runtime.Symbol;
%%
%class Lexer
%column
%line
%type java_cup.runtime.Symbol
%cup
%full
%char
L=[a-zA-Z_]+
D=[0-9]+
Positivo = "+"
Negativo="-"
operador = "/"|"*"|"%"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"||"|"!"|"."|"["|"]"|"{"|"}"|"[]"|"()"|"{}"|"#"|"##"
At = "@";
ParentesisA = "(";
ParentesisC = ")";
espacio=[\t\r\n]+
errorComentario = "/*"[^"*/"]*
comentarioM=(("/")("*")([^"/*"])*("*")("/"))
comentarioU=\-\-[^\n]*
Entero = \^[\-\+]?\d+
float = [\-\+]?[0-9]+\.[0-9]*([eE][\-\+]?[0-9]+)?
cadenaD = (\")[^\n]*(\")
cadenaU = (\')[^\n]*(\')
Null = "NULL"
bool = (1|0)
fin = (";"|"GO")
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
                     "LOAD"|"MERGE"|"NATIONAL"|"NOCHECK"|"NONCLUSTERED"|"NOT"|"NULLIF"|"OF"|"OFF"|
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
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%
({comentarioU}|{comentarioM})   {return new Symbol(sym.Comentario, yychar, yyline, yytext());}
{errorComentario}               {return new Symbol(sym.Comentario_Incompleto, yychar, yyline, yytext());}
{espacio}                       {/*Ignore*/}
{Entero}                        {return new Symbol(sym.Entero, yychar, yyline, yytext());}
{float}                         {return new Symbol(sym.Decimal, yychar, yyline, yytext());}
({cadenaD}|{cadenaU})           {return new Symbol(sym.String, yychar, yyline, yytext());}
{bool}                          {return new Symbol(sym.Boolean, yychar, yyline, yytext());}
{operador}                      {return new Symbol(sym.Operador, yychar, yyline, yytext());}
SELECT                          {return new Symbol(sym.Select, yychar, yyline, yytext());}
FROM                            {return new Symbol(sym.From, yychar, yyline, yytext());}
WHERE                           {return new Symbol(sym.Where, yychar, yyline, yytext());}
INSERT                          {return new Symbol(sym.Insert, yychar, yyline, yytext());}
INTO                            {return new Symbol(sym.Into, yychar, yyline, yytext());}
TOP                             {return new Symbol(sym.Top, yychar, yyline, yytext());}
OPENQUERY                       {return new Symbol(sym.OpenQuery, yychar, yyline, yytext());}
OPENROWSET                      {return new Symbol(sym.OpenRowset, yychar, yyline, yytext());}
VALUES                          {return new Symbol(sym.Values, yychar, yyline, yytext());}
DEFAULT VALUES                  {return new Symbol(sym.DefaultValues, yychar, yyline, yytext());}
DEFAULT                         {return new Symbol(sym.Default, yychar, yyline, yytext());}
{Null}                          {return new Symbol(sym.Null, yychar, yyline, yytext());}
AND                             {return new Symbol(sym.And, yychar, yyline, yytext());}
OR                              {return new Symbol(sym.Or, yychar, yyline, yytext());}
NOT                             {return new Symbol(sym.Not, yychar, yyline, yytext());}
ALL                             {return new Symbol(sym.All, yychar, yyline, yytext());}
SOME                            {return new Symbol(sym.Some, yychar, yyline, yytext());}
BETWEEN                         {return new Symbol(sym.Between, yychar, yyline, yytext());}
LIKE                            {return new Symbol(sym.Like, yychar, yyline, yytext());}
IN                              {return new Symbol(sym.In, yychar, yyline, yytext());}
EXISTS                          {return new Symbol(sym.Exists, yychar, yyline, yytext());}
SUM                             {return new Symbol(sym.Sum, yychar, yyline, yytext());}
DISTINCT                        {return new Symbol(sym.Distinct, yychar, yyline, yytext());}
{ParentesisA}                   {return new Symbol(sym.ParentesisA, yychar, yyline, yytext());}
{ParentesisC}                   {return new Symbol(sym.ParentesisC, yychar, yyline, yytext());}
","                             {return new Symbol(sym.Comma, yychar, yyline, yytext());}
";"                             {return new Symbol(sym.PuntoComma, yychar, yyline, yytext());}
"."                             {return new Symbol(sym.Punto, yychar, yyline, yytext());}
{At}                            {return new Symbol(sym.At, yychar, yyline, yytext());}
{Positivo}                      {return new Symbol(sym.Positivo, yychar, yyline, yytext());}
{Negativo}                      {return new Symbol(sym.Negativo, yychar, yyline, yytext());}
{fin}                           {return new Symbol(sym.FinSentencia, yychar, yyline, yytext());}
{L}({L}|{D})*                   {return new Symbol(sym.Identificador, yychar, yyline, yytext());}
 .                              {return new Symbol(sym.ERROR, yychar, yyline, yytext());}
