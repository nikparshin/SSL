#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Движения.ОтветыНаВопросыАнкет.Записывать = Истина;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ТаблицаСостав.Вопрос,
	|	ТаблицаСостав.ЭлементарныйВопрос,
	|	ТаблицаСостав.НомерЯчейки,
	|	ТаблицаСостав.Ответ,
	|	ТаблицаСостав.ОткрытыйОтвет,
	|	ТаблицаСостав.НомерСтроки
	|ПОМЕСТИТЬ Состав
	|ИЗ
	|	&ТаблицаСостав КАК ТаблицаСостав
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Состав.Вопрос,
	|	Состав.ЭлементарныйВопрос,
	|	Состав.НомерЯчейки,
	|	Состав.Ответ,
	|	Состав.ОткрытыйОтвет,
	|	ИСТИНА КАК Активность,
	|	&Ссылка КАК Регистратор,
	|	&Ссылка КАК Анкета,
	|	Состав.НомерСтроки КАК НомерСтроки
	|ИЗ
	|	Состав КАК Состав";
	
	Запрос.УстановитьПараметр("ТаблицаСостав",Состав);
	Запрос.УстановитьПараметр("Ссылка",Ссылка);
	
	Движения.ОтветыНаВопросыАнкет.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ДанныеЗаполнения <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,ДанныеЗаполнения);
	КонецЕсли;
	
	Если РежимАнкетирования = Перечисления.РежимыАнкетирования.Интервью Тогда
		Интервьюер = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если РежимАнкетирования = Перечисления.РежимыАнкетирования.Интервью Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("Опрос"));
	Иначе
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("ШаблонАнкеты"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли