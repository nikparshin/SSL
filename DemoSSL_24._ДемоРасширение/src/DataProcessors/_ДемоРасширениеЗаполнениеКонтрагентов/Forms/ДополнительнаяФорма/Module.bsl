#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	Для Каждого Контрагент Из Параметры.ПараметрКоманды Цикл
		ОбъектыНазначения.Добавить(Контрагент);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Если Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДлительнаяОперация
		И ПоказатьДиалогПередЗакрытием Тогда
		Отказ = Истина;
		
		ТекстВопроса = НСтр("ru = 'Прервать замену элементов и закрыть форму?'");
		
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить(КодВозвратаДиалога.Прервать, НСтр("ru = 'Прервать'"));
		Кнопки.Добавить(КодВозвратаДиалога.Нет,      НСтр("ru = 'Не прерывать'"));
		
		Обработчик = Новый ОписаниеОповещения("ПослеПодтвержденияОтменыЗадания", ЭтотОбъект);
		
		ПоказатьВопрос(Обработчик, ТекстВопроса, Кнопки, , КодВозвратаДиалога.Нет);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьПрефиксКНаименованию(Команда)
	Состояние(НСтр("ru = 'Идет добавление префикса к реквизиту ""Наименование""...'"));
	
	ДлительнаяОперация = ДлительнаяОперацияЗапускСервер();
	
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	НастройкиОжидания.ВыводитьОкноОжидания = Ложь;
	
	Обработчик = Новый ОписаниеОповещения("ДлительнаяОперацияЗавершениеКлиент", ЭтотОбъект);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Обработчик, НастройкиОжидания);
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть(Ложь);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ДлительнаяОперацияЗапускСервер()
	Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДлительнаяОперация;
	Элементы.ДобавитьПрефиксКНаименованию.Видимость = Ложь;
	ПоказатьДиалогПередЗакрытием = Истина;
	
	ИмяМетода = "Обработки._ДемоРасширениеЗаполнениеКонтрагентов.ВыполнитьКомандуВФоне";
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("ПараметрКоманды", ОбъектыНазначения.ВыгрузитьЗначения());
	ПараметрыПроцедуры.Вставить("ОписаниеКоманды", Параметры.ОписаниеКоманды);
	
	НастройкиЗапуска = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	НастройкиЗапуска.НаименованиеФоновогоЗадания = НСтр("ru = 'Демо: Заполнение контрагентов'");
	НастройкиЗапуска.ОжидатьЗавершение = 0;
	
	Возврат ДлительныеОперации.ВыполнитьВФоне(ИмяМетода, ПараметрыПроцедуры, НастройкиЗапуска);
КонецФункции

&НаКлиенте
Процедура ДлительнаяОперацияЗавершениеКлиент(Операция, ДополнительныеПараметры) Экспорт
	Если Операция = Неопределено Тогда
		Возврат; // Задание отменено.
	КонецЕсли;
	ПоказатьДиалогПередЗакрытием = Ложь;
	Обработчик = Новый ОписаниеОповещения("ДлительнаяОперацияПослеВыводаРезультата", ЭтотОбъект);
	Если Операция.Статус = "Выполнено" Тогда
		ПоказатьОповещениеПользователя(НСтр("ru = 'Префиксы успешно добавлены'"),,, БиблиотекаКартинок.Успешно32);
		ВыполнитьОбработкуОповещения(Обработчик);
	Иначе
		ВызватьИсключение Операция.КраткоеПредставлениеОшибки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДлительнаяОперацияПослеВыводаРезультата(ПустойПараметр, Результат) Экспорт
	ОповеститьОбИзменении(Тип("СправочникСсылка._ДемоКонтрагенты"));
	Если ТипЗнч(ВладелецФормы) = Тип("УправляемаяФорма") И ВладелецФормы.ИмяФормы = "Справочник._ДемоКонтрагенты.Форма.ФормаЭлемента" Тогда
		ВладелецФормы.Прочитать();
	КонецЕсли;
	Если Открыта() Тогда
		Закрыть(Истина);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПослеПодтвержденияОтменыЗадания(Ответ, ПараметрыВыполнения) Экспорт
	Если Ответ = КодВозвратаДиалога.Прервать
		И Элементы.Страницы.ТекущаяСтраница = Элементы.СтраницаДлительнаяОперация Тогда
		ПоказатьДиалогПередЗакрытием = Ложь;
		Закрыть(Ложь);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти