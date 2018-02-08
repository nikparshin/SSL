#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	ЭтоТовары = Не ОбщегоНазначения.ПустойБуферОбмена("Товары");
	Элементы.ТоварыВставитьСтроки.Доступность = ЭтоТовары;
	Элементы.ТоварыВставитьСтрокиМеню.Доступность = ЭтоТовары;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ДанныеСкопированыВБуферОбмена" Тогда
		ЭтоТовары = (Параметр.Источник = "Товары");
		Элементы.ТоварыВставитьСтроки.Доступность = ЭтоТовары;
		Элементы.ТоварыВставитьСтрокиМеню.Доступность = ЭтоТовары;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись__ДемоОприходованиеТоваров", Новый Структура, Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура СкопироватьСтроки(Команда)
	
	Если Элементы.Товары.ВыделенныеСтроки.Количество() = 0 Тогда
		Возврат;	
	КонецЕсли;
	
	СкопироватьСтрокиНаСервере();
	ПоказатьОповещениеПользователя(НСтр("ru = 'Копирование в буфер обмена'"), Окно.ПолучитьНавигационнуюСсылку(), 
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Скопировано товаров: %1'"), Элементы.Товары.ВыделенныеСтроки.Количество()));
	Оповестить("ДанныеСкопированыВБуферОбмена", Новый Структура("Источник", "Товары"), Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ВставитьСтроки(Команда)
	
	Количество = ВставитьСтрокиНаСервере();
	Если Количество > 0 Тогда
		ПоказатьОповещениеПользователя(НСтр("ru = 'Вставка из буфера обмена'"), Окно.ПолучитьНавигационнуюСсылку(), 
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Вставлено товаров: %1'"), Количество));
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СкопироватьСтрокиНаСервере()
	
	ОбщегоНазначения.СкопироватьСтрокиВБуферОбмена(Объект.Товары, Элементы.Товары.ВыделенныеСтроки, "Товары");

КонецПроцедуры

&НаСервере
Функция ВставитьСтрокиНаСервере()
	
	ДанныеИзБуфераОбмена = ОбщегоНазначения.СтрокиИзБуфераОбмена();
	Если ДанныеИзБуфераОбмена.Источник <> "Товары" Тогда
		Возврат 0;
	КонецЕсли;
		
	Таблица = ДанныеИзБуфераОбмена.Данные;
	Для Каждого СтрокаТаблицы Из Таблица Цикл
		ЗаполнитьЗначенияСвойств(Объект.Товары.Добавить(), СтрокаТаблицы);
	КонецЦикла;
	Возврат Таблица.Количество();
	
КонецФункции

#КонецОбласти