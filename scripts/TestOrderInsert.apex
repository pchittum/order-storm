Account testAcct = [Select Id, Name FROM Account LIMIT 1];

System.debug('Test Account: ' + testAcct.Name);

Order testOrder = new Order(
    AccountId = testAcct.Id,
    EffectiveDate = Date.today(),
    Status = 'Draft',
    Name = 'Test Order'
);

insert testOrder;