
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Счет", ОтборСчет);
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Счет", ОтборСчет, ВидСравненияКомпоновкиДанных.ВИерархии);
	
	Параметры.Отбор.Свойство("Организация", ОтборОрганизация);
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", ОтборОрганизация);
	
	Параметры.Отбор.Свойство("Регистратор", ОтборРегистратор);
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Регистратор", ОтборРегистратор);
	
	Элементы.ОтборРегистратор.ОграничениеТипа = Метаданные.РегистрыБухгалтерии._ДемоОсновной.СтандартныеРеквизиты.Регистратор.Тип;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ОтборСчетПриИзменении(Элемент)
	
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Счет", ОтборСчет, ВидСравненияКомпоновкиДанных.ВИерархии);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияПриИзменении(Элемент)
	
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Организация", ОтборОрганизация);

КонецПроцедуры

&НаКлиенте
Процедура ОтборРегистраторПриИзменении(Элемент)
	
	УстановитьЭлементОтбораДинамическогоСписка(Список, "Регистратор", ОтборРегистратор);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПереключитьАктивностьПроводок(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Или Не ЗначениеЗаполнено(ТекущиеДанные.Регистратор) Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Не выбран документ'"));
		Возврат;
	КонецЕсли;
	
	ПереключитьАктивностьПроводокСервер(ТекущиеДанные.Регистратор);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПереключитьАктивностьПроводокСервер(Документ)
	
	Если Не Документ.ПометкаУдаления Тогда
		
		Проводки = РегистрыБухгалтерии._ДемоОсновной.СоздатьНаборЗаписей();
		Проводки.Отбор.Регистратор.Установить(Документ);
		Проводки.Прочитать();

		Если Проводки.Количество() > 0 Тогда
			Проводки.УстановитьАктивность(Не Проводки[0].Активность);
			Проводки.Записать();
			
			Элементы.Список.Обновить();
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЭлементОтбораДинамическогоСписка(Знач ДинамическийСписок, Знач ИмяПоля, Знач ПравоеЗначение, Знач ВидСравнения = Неопределено)
	
	Если ВидСравнения = Неопределено Тогда
		ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ДинамическийСписок.Отбор, ИмяПоля, ПравоеЗначение, ВидСравнения, ,
		ЗначениеЗаполнено(ПравоеЗначение), РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

#КонецОбласти
