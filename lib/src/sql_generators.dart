part of dooq;


abstract class SqlGenerator {
  String get INTEGER;
  String get INT;
  String get SMALLINT;
  String get TINYINT;
  String get MEDIUMINT;
  String get BIGINT;
  String get INTEGER_UNSIGNED;
  String get INT_UNSIGNED;
  String get SMALLINT_UNSIGNED;
  String get TINYINT_UNSIGNED;
  String get MEDIUMINT_UNSIGNED;
  String get BIGINT_UNSIGNED;

  //Exact values
  String NUMERIC(int precision, int scale);
  String DECIMAL(int precision, int scale);

  //Approximate Value
  String FLOAT([int m, int d]);
  String DOUBLE([int m, int d]);
  String DOUBLE_PRECISION(int m, int d);

  String BIT(int M);

  /**
   *  format: 'YYYY-MM-DD' or 'YY-MM-DD'
   *  range: 1000-01-01 to 9999-12-31
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String get DATE;

  /**
   * format:  'YYYY-MM-DD HH:MM:SS[.FFFFFF]'
   * range:   '1000-01-01 00:00:00[.000000]' to '9999-12-31 23:59:59[.999999]'
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String DATETIME([int fsp = 0]);

  /**
   * format:  'YYYY-MM-DD HH:MM:SS[.FFFFFF]'
   * range:   '1970-01-01 00:00:01[.000000]' to '2038-01-19 03:14:07[.999999]'
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String TIMESTAMP([int fsp = 0]);

  /**
   * format: 'HHH:MM:SS'
   * range:  '-838:59:59' to '838:59:59'
   */
  String TIME([int fsp = 0]);

  /**
   * format: 'YYYY' or 'YY' if s = 2
   * range:  '1901' to '2015' or '70' = '1970' to '99' = '1999' and '00' = '2000' to '69' = '2069' 
   */
  String YEAR([int s = 4]);

  String CHAR(int length);
  String VARCHAR(int length);

  String BINARY(int length);
  String VARBINARY(int length);

  String NCHAR(int length);
  String NVARCHAR(int length);

  String get BLOB;
  String get TYINYBLOB;
  String get MEDIUMBLOG;
  String get LONGBLOB;

  String get TEXT;
  String get TYNYTEXT;
  String get MEDIUMTEXT;
  String get LONGTEXT;

  String ENUM(Set<String> vals);
  String SET(Set<String> vals);

//  String get SERIAL;
//  String get SMALLSERIAL;
//  String get BIGSERIAL;
//  String get BOOLEAN;
//  String get CLOB;
//  String get REAL;
//  String get ARRAY;
//  String get DATALINK;
//  String get REF;
//  String get ROWID;
//  String get SQLXML;
//  String get OTHER;
//  String get STRUCT;
  
  final NULL = 'NULL',
        DISTINCT = 'DISTINCT',
        NOT_NULL = 'NOT NULL',
        PRIMARY_KEY = 'PRIMARY KEY',
        UNIQUE = 'UNIQUE';
  
  String DEFAULT(String val);

  String createTable(Table table);

  String deleteTable(String tableName) => 'DROP TABLE $tableName';
  
  String alterTable(String tableName, List<String> modifications) => 'ALTER TABLE $tableName\n\t${modifications.join(",\n")};';
  
  String addColumn(Column column) => 'ADD COLUMN $column;';
    
  String modifyColumn(Column column) => 'MODIFY COLUMN $column';
  
  String dropColumn(String column) => 'DROP COLUMN $column';

  String createIndex(String indexName, String tableName, List<String> columns) => 'CREATE INDEX $indexName ON $tableName $columns';
  
  String addIndex(String indexName, List<String> columns) => 'ADD INDEX $indexName $columns';
  
  String dropIndex(String indexName) => 'DROP INDEX $indexName';
  
  String modifyIndex(String indexName, List<String> columns) => 'MODIFY INDEX $indexName $columns';
  
  String addPrimaryKey(String tableName, List<String> columns) => 'ADD $PRIMARY_KEY $columns';
  
  String dropPrimaryKey() => 'DROP $PRIMARY_KEY';
  
  String modifyPrimaryKey(List<String> columns) => 'MODIFY $PRIMARY_KEY $columns';
}

class Table {
  Table(this.name, {this.columns, this.constraints, this.temporary : false, this.alias});
  final String name;
  final String alias;
  final List<Column> columns;
  bool temporary;
  List<Constraint> constraints =  [new PrimaryKey('pk_id', const ['ID'])];
}

class Column {
  Column(this.name, {this.alias, this.dataType, this.constraints});
  
  final String name;
  final String alias;
  final String dataType;
  final List<String> constraints;
  
  String toString() => '$name $dataType${constraints == null ? "" : " " + constraints.join(" ")}';
}

String columnsToString(List<Column> columns) => '${columns.map((col) => '$col').join(",\n\t")}';

class ForeignKey extends Constraint {
  ForeignKey(String name, this.fkName, this.refTableName, this.refTablePkName) : super(name);
  
  final String fkName;
  final String refTableName;
  final String refTablePkName;
  
  String toString() => '';
}

abstract class Constraint {
  Constraint(this.name);
  
  final String name;
}

constraintsToString(List<Constraint> constraints) => '${constraints.map((constraint) => '$constraint').join(",\n\t")}';

class Check extends Constraint {
  Check(String name, [this._val]) : super(name);
  
  String _val = '';
  pb() { _val += '('; }
  pe() { _val += ')'; }
  or(String val) { val += 'OR $val'; }
  and(String val) { val += 'AND $val'; }
  
  String toString() => 'CONSTRAINT $name CHECK ($_val)';
}

class Unique extends Constraint {
  Unique(String name, this.columns) : super(name);
  
  List<String> columns;
  
  String toString() => 'CONSTRAINT $name UNIQUE (${columns.join(", ")})';
}

class PrimaryKey extends Constraint {
  PrimaryKey(String name, this.columns) : super(name);
  
  final List<String> columns;
  
  String toString() => 'PRIMARY KEY $name (${columns.join(", ")})';
}

//someFunc(String first, String last) {
//  ConnectionPool pool;
//  
//  pool.select(['first_name', 'last_name'], from('person', 'p')
//      ..innerJoin('address', 'a')
//        //WHERE (p.first = :first OR p.last = :last) AND p.age = 5
//        .where(eq('p.name', first, or(eq('p.last', last))), and(eq('p.age', '5'))));
//}

From from(String tableName, [String alias]) => new From(new Table(tableName, alias: alias));

class From {
  Table _table;
  _Join innerJoin(String tableName, [String alias]) => new _Join('INNER', new Table(tableName, alias: alias));
  _Join leftJoin(String tableName, [String alias]) => new _Join('LEFT', new Table(tableName, alias: alias));
  _Join rightJoin(String tableName, [String alias]) => new _Join('RIGT', new Table(tableName, alias: alias));
  _Join fullJoin(String tableName, [String alias]) => new _Join('FULL', new Table(tableName, alias: alias));
  
  Where where(Condition firstCondition, [List<LogicOp> logicOps]) => new Where(firstCondition);
  
  From(this._table);
}

class Where {
  Condition firstCondition;
  
  Where(this.firstCondition, [List<LogicOp> logicOp]);
}

and(Condition condition, [LogicOp other]) => new LogicOp('AND', condition, other);
or(Condition condition, [LogicOp other]) => new LogicOp('OR', condition, other);

class LogicOp {
  Condition condition;
  String logicOpType;
  LogicOp other;
  
  LogicOp(this.logicOpType, this.condition, [this.other]);
  
  String toString() {
    var condStr = '$logicOpType $condition';
    if(other == null) {
      return condStr;
    } else {
      return '$condStr $other';
    }
  }
}

Condition gt(String column, String value, [LogicOp  logicOp]) => new Condition(column, '>', value, logicOp);
Condition eq(String column, String value, [LogicOp  logicOp]) => new Condition(column, '=', value, logicOp);

class Condition {
  Condition(this.column, this.conditionType, this.value, [this.logicOp]);
  
  String column;
  String value;
  String conditionType;
  LogicOp  logicOp;
  
  //TODO: add sql injection protection
  
  String toString() {
    var condStr = '$column $conditionType $value';
    if(logicOp == null) {
      return condStr;
    } else {
      return '($condStr $logicOp)';
    }
  }
}

class _Join {
  String _joinType;
  Table _table;
  Where where(Condition firstCondition, [List<LogicOp> logicOps]) => new Where(firstCondition, logicOps);
  
  _Join(this._joinType, this._table);
  
}

class Select {
  List<String> columns;
  
  Table from(Table table) {
    return table;
  }
  
}

//class Column {
//  final String name;
//  final String alias;
//  
//  Column(this.name, [this.alias]);
//}
//
//class Table {
//  final String name;
//  final String alias;
//  
//  Table(this.name, [this.alias]);
//}
