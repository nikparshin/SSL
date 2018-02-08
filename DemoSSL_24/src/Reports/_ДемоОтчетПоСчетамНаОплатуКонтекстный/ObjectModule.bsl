#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// Возвращает сведения о внешнем отчете.
//
// Возвращаемое значение:
//   Структура - Подробнее см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке().
//
Функция СведенияОВнешнейОбработке() Экспорт
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.2.5.1");
	ПараметрыРегистрации.Информация = НСтр("ru = 'Отчет по документам ""Демо: Счет на оплату покупателю"". Используется для демонстрации возможностей подсистемы ""Дополнительные отчеты и обработки"".'");
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиОтчет();
	ПараметрыРегистрации.Версия = "2.4.1.1";
	ПараметрыРегистрации.Назначение.Добавить("Документ._ДемоСчетНаОплатуПокупателю");
	ПараметрыРегистрации.ОпределитьНастройкиФормы = Истина;
	
	Команда = ПараметрыРегистрации.Команды.Добавить();
	Команда.Представление = НСтр("ru = 'Список используемой номенклатуры в счетах на оплату'");
	Команда.Идентификатор = "Основная";
	Команда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	Команда.ПоказыватьОповещение = Ложь;
	
	Возврат ПараметрыРегистрации;
КонецФункции

// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// СтандартныеПодсистемы.ВариантыОтчетов

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - УправляемаяФорма, Неопределено - Форма отчета или форма настроек отчета.
//       Неопределено когда вызов без контекста.
//   КлючВарианта - Строка, Неопределено - Имя предопределенного
//       или уникальный идентификатор пользовательского варианта отчета.
//       Неопределено когда вызов без контекста.
//   Настройки - Структура - см. возвращаемое значение
//       ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.ФормироватьСразу = Истина;
	Настройки.РазрешеноИзменятьВарианты = Ложь;
	Настройки.События.ПриСозданииНаСервере = Истина;
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
// См. также УправляемаяФорма.ПриСозданииНаСервере в синтакс-помощнике.
//
// Параметры:
//   Форма - УправляемаяФорма - Форма отчета.
//   Отказ - Булево - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Булево - Передается из параметров обработчика "как есть".
//
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	ОбъектыНазначения = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(Форма.Параметры, "ОбъектыНазначения");
	Если ОбъектыНазначения <> Неопределено Тогда
		Форма.ФормаПараметры.Отбор.Вставить("Ссылка", ОбъектыНазначения);
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#КонецЕсли