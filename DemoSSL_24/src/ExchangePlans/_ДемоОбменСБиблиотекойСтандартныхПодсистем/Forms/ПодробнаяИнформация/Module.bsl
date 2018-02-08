
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Макет = ПланыОбмена._ДемоОбменСБиблиотекойСтандартныхПодсистем.ПолучитьМакет("ПодробнаяИнформация");
	
	ПолеHTMLДокумента = Макет.ПолучитьТекст();
	
	Заголовок = НСтр("ru = 'Информация о синхронизации данных с 1С:Библиотека стандартных подсистем'");

КонецПроцедуры

#КонецОбласти