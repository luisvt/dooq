library dooq;

import 'dart:collection';
//import 'package:drails_commons/drails_commons.dart';


part 'src/sql_generators.dart';
part 'src/impl/mysql_generators.dart';
part 'src/impl/postgresql_generators.dart';

//
//class DataType extends Enum {
//  static const DataType ARRAY = const DataType("ARRAY");
//  static const DataType BIGINT = const DataType("BIGINT");
//  static const DataType BINARY = const DataType("BINARY");
//  static const DataType BIT = const DataType("BIT");
//  static const DataType BLOB = const DataType("BLOB");
//  static const DataType BOOLEAN = const DataType("BOOLEAN");
//  static const DataType CHAR = const DataType("CHAR", _CHAR);
//  static const DataType CLOB  = const DataType("CLOB");
//  static const DataType DATALINK = const DataType("DATALINK");
//  static const DataType DATE = const DataType("DATE");
//  static const DataType DECIMAL = const DataType("DECIMAL");
//  static const DataType DISTINCT = const DataType("DISTINCT");
//  static const DataType DOUBLE = const DataType("DOUBLE", _DOUBLE);
//  static const DataType FLOAT = const DataType("FLOAT", _FLOAT);
//  static const DataType INTEGER = const DataType("INTEGER");
//  static const DataType DART_OBJECT = const DataType("DART_OBJECT");
//  static const DataType LONGNVARCHAR = const DataType("LONGNVARCHAR", _LONGNVARCHAR);
//  static const DataType LONGVARBINARY = const DataType("LONGVARBINARY", _LONGVARBINARY);
//  static const DataType LONGVARCHAR = const DataType("LONGVARCHAR", _LONGVARCHAR);
//  static const DataType NCHAR = const DataType("NCHAR", _NCHAR);
//  static const DataType NCLOB = const DataType("NCLOB");
//  static const DataType NULL = const DataType("NULL");
//  static const DataType NUMERIC = const DataType("NUMERIC", _NUMERIC);
//  static const DataType NVARCHAR = const DataType("NVARCHAR", _NVARCHAR);
//  static const DataType OTHER = const DataType("OTHER");
//  static const DataType REAL = const DataType("REAL");
//  static const DataType REF = const DataType("REF");
//  static const DataType ROWID = const DataType("ROWID");
//  static const DataType SMALLINT = const DataType("SMALLINT");
//  static const DataType SQLXML = const DataType("SQLXML");
//  static const DataType STRUCT = const DataType("STRUCT");
//  static const DataType TIME = const DataType("TIME");
//  static const DataType TIMESTAMP = const DataType("TIMESTAMP");
//  static const DataType TINYINT = const DataType("TINYINT");
//  static const DataType VARBINARY = const DataType("VARBINARY", _VARBINARY);
//  static const DataType VARCHAR = const DataType("VARCHAR", _VARCHAR);
//  
//  final Function func;
//
//  const DataType(String name, [this.func = null]) : super(name);
//}
//
//
//String _FLOAT(int precision) => 'FLOAT($precision)'; 
//String _DOUBLE(int precision) => 'DOUBLE($precision)';
//String _NUMERIC(int p, int s) => 'NUMERIC($p, $s)';
//
//String _VARBINARY(int length) => "BIT($length)";
//String _LONGVARBINARY(int length) => "bit($length)";
//
//String _CHAR(int length) => "CHAR($length)";
//String _VARCHAR(int length) => "VARCHAR($length)";
//String _LONGVARCHAR(int length) => "VARCHAR($length)";
//
//String _NCHAR(int length) => "NCHAR($length)";
//String _NVARCHAR(int length) => "NVARCHAR($length)";
//String _LONGNVARCHAR(int length) => "NVARCHAR($length)";
