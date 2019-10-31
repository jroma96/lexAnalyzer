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
operador = "/"|"*"|"%"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"||"|"!"|"["|"]"|"{"|"}"|"[]"|"()"|"{}"|"#"|"##"
At = "@"
ParentesisA = "("
ParentesisC = ")"
espacio=[\s\t\r]+
errorComentario = "/*"[^"*/"]*
comentarioM=[/][*][^]*[*][/]
comentarioU=\-\-[^\n]*
Entero = [\-\+]?\d+
float = [\-\+]?[0-9]+\.[0-9]*([eE][\-\+]?[0-9]+)?
cadenaD = (\")[^]*(\")
cadenaU = (\')[^']*(\')
Null = "NULL"
bool = (1|0)
fin = (";"|"GO")
Punto = [\.]


%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%
({comentarioU}|{comentarioM})   {/*Ignore*/}
{errorComentario}               {return new Symbol(sym.Comentario_Incompleto, yychar, yyline, yytext());}
{espacio}                       {/*Ignore*/}
{Entero}                        {return new Symbol(sym.Entero, yychar, yyline, yytext());}
{float}                         {return new Symbol(sym.Decimal, yychar, yyline, yytext());}
({cadenaD}|{cadenaU})           {return new Symbol(sym.String, yychar, yyline, yytext());}
{bool}                          {return new Symbol(sym.Boolean, yychar, yyline, yytext());}
"*"                             {return new Symbol(sym.Star, yychar, yyline, yytext());}
{operador}                      {return new Symbol(sym.Operador, yychar, yyline, yytext());}
PROCEDURE|PROC                  {return new Symbol(sym.Procedure, yychar, yyline, yytext());}
COLUMN                          {return new Symbol(sym.Column, yychar, yyline, yytext());}
BEGIN                           {return new Symbol(sym.Begin, yychar, yyline, yytext());}
END                             {return new Symbol(sym.End, yychar, yyline, yytext());}
TRANSACTION|TRAN                {return new Symbol(sym.Transaction, yychar, yyline, yytext());}
COMMIT                          {return new Symbol(sym.Commit, yychar, yyline, yytext());}
ROLLBACK                        {return new Symbol(sym.Rollback, yychar, yyline, yytext());}
FUNCTION                        {return new Symbol(sym.Function, yychar, yyline, yytext());}
SAVE                            {return new Symbol(sym.SavePoint, yychar, yyline, yytext());}
DECLARE                         {return new Symbol(sym.Declare, yychar, yyline, yytext());}
CURSOR                          {return new Symbol(sym.Cursor, yychar, yyline, yytext());}
LOCAL                           {return new Symbol(sym.Local, yychar, yyline, yytext());}
GLOBAL                          {return new Symbol(sym.Global, yychar, yyline, yytext());}
FOR                             {return new Symbol(sym.For, yychar, yyline, yytext());}
OPEN                            {return new Symbol(sym.Open, yychar, yyline, yytext());}
FETCH                           {return new Symbol(sym.Fetch, yychar, yyline, yytext());}
NEXT                            {return new Symbol(sym.Next, yychar, yyline, yytext());}
RETURNS|RETURN                  {return new Symbol(sym.Returns, yychar, yyline, yytext());}
SET                             {return new Symbol(sym.Set, yychar, yyline, yytext());}
UPDATE                          {return new Symbol(sym.Update, yychar, yyline, yytext());}
OUTPUT|OUT                      {return new Symbol(sym.Output, yychar, yyline, yytext());}
PERCENT                         {return new Symbol(sym.Percent, yychar, yyline, yytext());}
DELETE                          {return new Symbol(sym.Delete, yychar, yyline, yytext());}
ADD                             {return new Symbol(sym.Add, yychar, yyline, yytext());}
MODIFY                          {return new Symbol(sym.Modify, yychar, yyline, yytext());}
CURRENT                         {return new Symbol(sym.Current, yychar, yyline, yytext());}
GROUP                           {return new Symbol(sym.Group, yychar, yyline, yytext());}
ALTER                           {return new Symbol(sym.Alter, yychar, yyline, yytext());}
INT                             {return new Symbol(sym.Int, yychar, yyline, yytext());}
FLOAT                           {return new Symbol(sym.Float, yychar, yyline, yytext());}
VARCHAR                         {return new Symbol(sym.Varchar, yychar, yyline, yytext());}
BIT                             {return new Symbol(sym.Bit, yychar, yyline, yytext());}
IDENTITY                        {return new Symbol(sym.Identity, yychar, yyline, yytext());}
CONSTRAINT                      {return new Symbol(sym.Constraint, yychar, yyline, yytext());}
PRIMARY                         {return new Symbol(sym.Primary, yychar, yyline, yytext());}
KEY                             {return new Symbol(sym.Key, yychar, yyline, yytext());}
COLLATE                         {return new Symbol(sym.Collate, yychar, yyline, yytext());}
NAME                            {return new Symbol(sym.Name, yychar, yyline, yytext());}
FILE                            {return new Symbol(sym.File, yychar, yyline, yytext());}
SIZE                            {return new Symbol(sym.Size, yychar, yyline, yytext());}
INCLUDE                         {return new Symbol(sym.Include, yychar, yyline, yytext());}
ASC                             {return new Symbol(sym.Asc, yychar, yyline, yytext());}
DESC                            {return new Symbol(sym.Desc, yychar, yyline, yytext());}
OBJECT                          {return new Symbol(sym.Object, yychar, yyline, yytext());}
CLUSTERED                       {return new Symbol(sym.Clustered, yychar, yyline, yytext());}
NONCLUSTERED                    {return new Symbol(sym.NonClustered, yychar, yyline, yytext());}
CREATE                          {return new Symbol(sym.Create, yychar, yyline, yytext());}
USER                            {return new Symbol(sym.User, yychar, yyline, yytext());}
UNIQUE                          {return new Symbol(sym.Unique, yychar, yyline, yytext());}
TRUNCATE                        {return new Symbol(sym.Truncate, yychar, yyline, yytext());}
IF                              {return new Symbol(sym.If, yychar, yyline, yytext());}
ON                              {return new Symbol(sym.On, yychar, yyline, yytext());}
DROP                            {return new Symbol(sym.Drop, yychar, yyline, yytext());}
LOGIN                           {return new Symbol(sym.Login, yychar, yyline, yytext());}
INDEX                           {return new Symbol(sym.Index, yychar, yyline, yytext());}
TABLE                           {return new Symbol(sym.Table, yychar, yyline, yytext());}
VIEW                            {return new Symbol(sym.View, yychar, yyline, yytext());}
DATABASE                        {return new Symbol(sym.Database, yychar, yyline, yytext());}
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
ORDER                           {return new Symbol(sym.Order, yychar, yyline, yytext());}
BY                              {return new Symbol(sym.By, yychar, yyline, yytext());}
COUNT                           {return new Symbol(sym.Count, yychar, yyline, yytext());}
MAX                             {return new Symbol(sym.Max, yychar, yyline, yytext());}
MIN                             {return new Symbol(sym.Min, yychar, yyline, yytext());}
DAY                             {return new Symbol(sym.Day, yychar, yyline, yytext());}
YEAR                            {return new Symbol(sym.Year, yychar, yyline, yytext());}
MONTH                           {return new Symbol(sym.Month, yychar, yyline, yytext());}
INNER                           {return new Symbol(sym.Inner, yychar, yyline, yytext());}
JOIN                            {return new Symbol(sym.Join, yychar, yyline, yytext());}
AS                              {return new Symbol(sym.As, yychar, yyline, yytext());}
DISTINCT                        {return new Symbol(sym.Distinct, yychar, yyline, yytext());}
{ParentesisA}                   {return new Symbol(sym.ParentesisA, yychar, yyline, yytext());}
{ParentesisC}                   {return new Symbol(sym.ParentesisC, yychar, yyline, yytext());}
{fin}                           {return new Symbol(sym.FinSentencia, yychar, yyline, yytext());}
","                             {return new Symbol(sym.Comma, yychar, yyline, yytext());}
";"                             {return new Symbol(sym.PuntoComma, yychar, yyline, yytext());}
"."                             {return new Symbol(sym.Punto, yychar, yyline, yytext());}
{At}                            {return new Symbol(sym.At, yychar, yyline, yytext());}
{Positivo}                      {return new Symbol(sym.Positivo, yychar, yyline, yytext());}
{Negativo}                      {return new Symbol(sym.Negativo, yychar, yyline, yytext());}
{L}({L}|{D})*                   {return new Symbol(sym.Identificador, yychar, yyline, yytext());}
 .                              {return new Symbol(sym.ERROR, yychar, yyline, yytext());}
