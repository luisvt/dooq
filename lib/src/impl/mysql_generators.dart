part of dooq;


class MysqlGenerator extends SqlGenerator {

  String get INTEGER => 'INTEGER';
  String get INT => 'INT';
  String get SMALLINT => 'SMALLINT';
  String get TINYINT => 'TINYINT';
  String get MEDIUMINT => 'MEDIUMINT';
  String get BIGINT => 'BIGINT';
  String get INTEGER_UNSIGNED => 'INTEGER_UNSIGNED';
  String get INT_UNSIGNED => 'INT_UNSIGNED';
  String get SMALLINT_UNSIGNED => 'SMALLINT_UNSIGNED';
  String get TINYINT_UNSIGNED => 'TINYINT_UNSIGNED';
  String get MEDIUMINT_UNSIGNED => 'MEDIUMINT_UNSIGNED';
  String get BIGINT_UNSIGNED => 'BIGINT UNSIGNED';

  //Exact values
  String NUMERIC(int p, int s) => 'NUMERIC($p, $s)';
  String DECIMAL(int p, int s) => "DECIMAL($p, $s)";
  
  //Approximate Value
  String FLOAT([int p, int s]) => 'FLOAT($p, $s)';
  String DOUBLE([int p, int s]) => 'DOUBLE($p, $s)';
  String DOUBLE_PRECISION(int m, int d) => 'DOUBLE_PRECISION($m, $d)';

  String BIT(int m) => "BIT($m)";

  /**
   *  format: 'YYYY-MM-DD' or 'YY-MM-DD'
   *  range: 1000-01-01 to 9999-12-31
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String get DATE => 'DATE';

  /**
   * format:  'YYYY-MM-DD HH:MM:SS[.FFFFFF]'
   * range:   '1000-01-01 00:00:00[.000000]' to '9999-12-31 23:59:59[.999999]'
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String DATETIME([int fsp = 0]) => 'DATETIME($fsp)';

  /**
   * format:  'YYYY-MM-DD HH:MM:SS[.FFFFFF]'
   * range:   '1970-01-01 00:00:01[.000000]' to '2038-01-19 03:14:07[.999999]'
   * 
   * Two-Digit Years:
   * - Year values in the range 00-69 are converted to 2000-2069.
   * - Year values in the range 70-99 are converted to 1970-1999. 
   */
  String TIMESTAMP([int fsp]) => 'TIMESTAMP(fsp)';

  /**
   * format: 'HHH:MM:SS'
   * range:  '-838:59:59' to '838:59:59'
   */
  String TIME([int fsp]) => 'TIME(fsp)';

  /**
   * format: 'YYYY' or 'YY' if s = 2
   * range:  '1901' to '2015' or '70' = '1970' to '99' = '1999' and '00' = '2000' to '69' = '2069' 
   */
  String YEAR([int s = 4]) => 'YEAR($s)';

  String CHAR(int length) => "CHAR($length)";
  String VARCHAR(int length) => "VARCHAR($length)";

  String BINARY(int length) => 'BINARY($length)';
  String VARBINARY(int length) => "VARBINARY($length)";

  String NCHAR(int length) => "NCHAR($length)";
  String NVARCHAR(int length) => "NVARCHAR($length)";

  String get BLOB => 'BLOB';
  String get TYINYBLOB => 'TYINYBLOB';
  String get MEDIUMBLOG => 'MEDIUMBLOG';
  String get LONGBLOB => 'LONGBLOB';

  String get TEXT => 'TEXT';
  String get TYNYTEXT => 'TYNYTEXT';
  String get MEDIUMTEXT => 'MEDIUMTEXT';
  String get LONGTEXT => 'LONGTEXT';

  String ENUM(Set<String> vals) => 'ENUM(${vals.join(", ")})';
  String SET(Set<String> vals) => 'SET(${vals.join(", ")})';

//  String get SERIAL => 'SERIAL';
//  String get SMALLSERIAL => 'SMALLSERIAL';
//  String get BIGSERIAL => 'BIGSERIAL';
//  String get BOOLEAN => 'BOOLEAN';
//  String get CLOB => 'CLOB';
//  String get REAL => 'REAL';
//  String get ARRAY => 'ARRAY';
//  String get DATALINK => 'DATALINK';
//  String get REF => 'REF';
//  String get ROWID => 'ROWID';
//  String get SQLXML => 'SQLXML';
//  String get OTHER => 'OTHER';
//  String get STRUCT => 'STRUCT';

//  String LONGVARBINARY(int length) => "bit($length)";
//
//  String LONGVARCHAR(int length) => "VARCHAR($length)";
//
//  String LONGNVARCHAR(int length) => "NVARCHAR($length)";

  String createTable(Table table) {
    var result = 'CREATE ${table.temporary ? "TEMPORARY " : ""}TABLE ${table.name} (\n\t'
           + (table.columns != null && table.columns.any((col) => col.constraints != null && col.constraints.any((constr) => constr == PRIMARY_KEY)) 
               || table.constraints != null && table.constraints.any((constr) => constr is PrimaryKey) ? "" : "ID $BIGINT_UNSIGNED $NOT_NULL $PRIMARY_KEY,\n\t")
           + columnsToString(table.columns) +
           '\n);';
    print(result);
    return result;
  }
  
  String addPrimaryKey(String tableName, List<String> columns, [String pkName]);
  
//  String dropPrimaryKey(String tableName, [String pkName]);
}
