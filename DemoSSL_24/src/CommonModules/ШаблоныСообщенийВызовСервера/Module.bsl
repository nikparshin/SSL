#Область СлужебныеПроцедурыИФункции

Функция ШаблонПоВладельцу(ВладелецШаблона) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ШаблоныСообщений.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШаблоныСообщений КАК ШаблоныСообщений
		|ГДЕ
		|	ШаблоныСообщений.ВладелецШаблона = &ВладелецШаблона";
	
	Запрос.УстановитьПараметр("ВладелецШаблона", ВладелецШаблона);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Возврат РезультатЗапроса.Выгрузить()[0].Ссылка;
	Иначе
		Возврат Справочники.ШаблоныСообщений.ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

#КонецОбласти
