#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Определяет состав программного интерфейса для интеграции с конфигурацией.
//
// Параметры:
//   Настройки - Структура - Настройки интеграции этого объекта.
//       См. возвращаемое значение функции ПодключаемыеКоманды.НастройкиПодключаемыхОтчетовИОбработок().
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
	Настройки.НастроитьВариантыОтчета = Истина;
	Настройки.ОпределитьНастройкиФормы = Истина;
	
	Настройки.ДобавитьКомандыОтчетов = Истина;
	Настройки.Размещение.Добавить(Метаданные.Документы._ДемоРеализацияТоваров);
	Настройки.Размещение.Добавить(Метаданные.Документы._ДемоПоступлениеТоваров);
	Настройки.Размещение.Добавить(Метаданные.Справочники._ДемоМестаХранения);
	
КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	Команда = КомандыОтчетов.Добавить();
	Команда.Представление = НСтр("ru = 'Остатки товаров (из расширения)'");
	Команда.КлючВарианта  = "Основной";
КонецПроцедуры

// Настройки размещения в панели отчетов.
//
// Параметры:
//   Настройки - Коллекция - Передается "как есть" из ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//       Может использоваться для получения настроек варианта этого отчета при помощи функции ВариантыОтчетов.ОписаниеВарианта().
//   НастройкиОтчета - СтрокаДереваЗначений - Настройки этого отчета,
//       уже сформированные при помощи функции ВариантыОтчетов.ОписаниеОтчета() и готовые к изменению.
//       См. "Свойства для изменения" процедуры ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Описание:
//   См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
// Вспомогательные методы:
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	ВариантыОтчетов.УстановитьРежимВыводаВПанеляхОтчетов(Настройки, НастройкиОтчета, Истина/Ложь);
//
// Примеры:
//
//  1. Установка описания варианта.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Описание = НСтр("ru = '<Описание>'");
//
//  2. Отключение варианта отчета.
//	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "<ИмяВарианта>");
//	НастройкиВарианта.Включен = Ложь;
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "Основной");
	НастройкиВарианта.Описание = НСтр("ru = 'Движения товаров на складах за период.'");
КонецПроцедуры

#КонецОбласти

#КонецЕсли