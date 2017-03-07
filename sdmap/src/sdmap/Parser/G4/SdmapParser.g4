﻿parser grammar SdmapParser;

options { tokenVocab=SdmapLexer; }

root:
	(namespace | namedSql)*;

namespace:
	KNamespace (SYNTAX|NSSyntax) OpenCurlyBrace
		(namespace | namedSql)*
	CloseCurlyBrace;

coreSql:
	(macro | plainText)+;

plainText:
	SQLText;

namedSql:
	KSql SYNTAX OpenCurlyBrace
		coreSql?
	CloseSql;

unnamedSql:
	KSql OpenCurlyBrace
		coreSql?
	CloseSql;

ifStatement:
	Hash If OpenBrace boolExpression CloseBrace
	OpenCurlyBrace
		coreSql?
	CloseCurlyBrace;

boolExpression: 
	SYNTAX
	SYNTAX (Equal | NotEqual) Null;

macro:
	Hash SYNTAX OpenAngleBracket
		macroParameter? (Comma macroParameter)*
	CloseAngleBracket;

macroParameter:
	Bool |
	SYNTAX |
	NSSyntax | 
	STRING |
	NUMBER |
	DATE |
	unnamedSql;

