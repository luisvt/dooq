import 'package:dooq/dooq.dart';
import 'package:unittest/unittest.dart';

main() {
  test('SQL Generator', () {
    var sg = new MysqlGenerator();
    var sqlScript = sg.createTable(new Table('EVENT', columns: [
//      new Column('ID', sg.BIGINT_UNSIGNED, [sg.NOT_NULL, sg.PRIMARY_KEY]),
      new Column('NAME', dataType: sg.NVARCHAR(30), constraints: [sg.NOT_NULL]),
      new Column('DESCRIPTION', dataType: sg.NVARCHAR(500))
    ]));
    expect(sqlScript, 'CREATE TABLE EVENT (\n\tID BIGINT UNSIGNED NOT NULL PRIMARY KEY,\n\tNAME NVARCHAR(30) NOT NULL,\n\tDESCRIPTION NVARCHAR(500)\n);');
  });
}