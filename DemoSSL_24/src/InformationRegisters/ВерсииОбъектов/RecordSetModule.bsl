#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		Запись.РазмерДанных = ВерсионированиеОбъектов.РазмерДанных(Запись.ВерсияОбъекта);
		
		ДанныеВерсии = Запись.ВерсияОбъекта.Получить();
		Запись.ЕстьДанныеВерсии = ДанныеВерсии <> Неопределено;
		
		Если ПустаяСтрока(Запись.КонтрольнаяСумма) И Запись.ЕстьДанныеВерсии Тогда
			Запись.КонтрольнаяСумма = ВерсионированиеОбъектов.КонтрольнаяСумма(ДанныеВерсии);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли