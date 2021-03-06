
#Область ПрограммныйИнтерфейс

// Истина, если есть группы номенклатуры
// 
// Возвращаемое значение:
//   Булево   - Ложь, если нет ни одной группы.
//
Функция ИспользуютсяГруппыНоменклатуры() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.ЭтоГруппа";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ИспользуютсяГруппы = НЕ РезультатЗапроса.Пустой();
	
	Возврат ИспользуютсяГруппы;
	
КонецФункции

// Истина, если есть избранные товары
// 
// Возвращаемое значение:
//   Булево   - Ложь, если нет ни одного избранного товара.
//
Функция ИспользуютсяИзбранныеТовары() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Номенклатура.Ссылка
		|ИЗ
		|	Справочник.Номенклатура КАК Номенклатура
		|ГДЕ
		|	Номенклатура.Избранное";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ИспользуютсяИзбранныеТовары = НЕ РезультатЗапроса.Пустой();
	
	Возврат ИспользуютсяИзбранныеТовары;
	
КонецФункции

// Истина, если есть штрихкоды номенклатуры
// 
// Возвращаемое значение:
//   Булево   - Ложь, если нет ни одного штрихкода номенклатуры.
//
Функция ИспользуютсяШтрихкоды() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Штрихкоды.Штрихкод
	|ИЗ
	|	РегистрСведений.Штрихкоды КАК Штрихкоды";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ИспользуютсяШтрихкоды = НЕ РезультатЗапроса.Пустой();
	
	Возврат ИспользуютсяШтрихкоды;
	
КонецФункции

// Истина, если есть алкогольная продукция
// 
// Возвращаемое значение:
//   Булево   - Ложь, если нет ни одного алкогольного товара.
//
Функция ИспользуетсяАлкогольнаяПродукция() Экспорт
	
	Возврат ПолучитьЗначениеКонстанты("ИспользоватьАлкогольнуюПродукцию");
	
КонецФункции

// Истина, используются скидки и наценки
// 
// Возвращаемое значение:
//   Булево
//
Функция ИспользуютсяСкидкиНаценки() Экспорт
	
	Возврат ПолучитьЗначениеКонстанты("ИспользоватьСкидкиНаценки");
	
КонецФункции

// Шрифт, по размеру из настроек
// 
// Возвращаемое значение:
//   Шрифт
//
Функция ШрифтПриложения() Экспорт
	
	РазмерШрифта = Константы.РазмерШрифта.Получить();
	
	Если НЕ ЗначениеЗаполнено(РазмерШрифта) Тогда
		
		РазмерШрифтаПриложения = 8;
		
	ИначеЕсли РазмерШрифта = Перечисления.РазмерШрифта.Крупный Тогда
		
		РазмерШрифтаПриложения = 10;
		
	ИначеЕсли РазмерШрифта = Перечисления.РазмерШрифта.ОченьКрупный Тогда
		
		РазмерШрифтаПриложения = 11;
		
	ИначеЕсли РазмерШрифта = Перечисления.РазмерШрифта.Мелкий Тогда
		
		РазмерШрифтаПриложения = 7;
		
	КонецЕсли;
	
	ШрифтПриложения = Новый Шрифт(, РазмерШрифтаПриложения);
	
	Возврат ШрифтПриложения;
	
КонецФункции

// Высота, по размеру из настроек
// 
// Возвращаемое значение:
//   Число
//
Функция ВысотаПоляНаименованиеТовара() Экспорт
	
	ВысотаПоля = ПолучитьЗначениеКонстанты("ВысотаПоляНаименованиеТовара");
	
	Возврат ВысотаПоля;
	
КонецФункции

// Форматная строка количественных полей из настроек (точность отображения количества).
// 
// Возвращаемое значение:
//   Строка
//
Функция ФорматКоличественныхПолей() Экспорт
	
	ФорматПолей = "ЧЦ=15; ЧДЦ=%ТочностьОтображенияКоличества%; ЧН=%ЧН%; ЧРД=.; ЧГ=0";
	
	ТочностьОтображенияКоличества = ПолучитьЗначениеКонстанты("ТочностьОтображенияКоличества");
	
	ФорматПолей = СтрЗаменить(ФорматПолей, "%ТочностьОтображенияКоличества%", ТочностьОтображенияКоличества);
	
	Если ТочностьОтображенияКоличества = 0 Тогда
		ЧН="0";
	Иначе
		ЧН="0.000";
		ЧН = Сред(ЧН, 1, ТочностьОтображенияКоличества + 2);
	КонецЕсли;
	
	ФорматПолей = СтрЗаменить(ФорматПолей, "%ЧН%", ЧН);
	
	Возврат ФорматПолей;
	
КонецФункции

// Форматная строка отображения даты: время и дата
// 
// Возвращаемое значение:
//   Строка
//
Функция ФорматДатыВремяИДата() Экспорт
	
	ФорматДаты = "ДФ='HH:mm:ss dd.MM.yyyy'";
	
	Возврат ФорматДаты;
	
КонецФункции

// Получение значения константы.
//
Функция ПолучитьЗначениеКонстанты(ИмяКонстанты) Экспорт

	Возврат Константы[ИмяКонстанты].Получить();

КонецФункции

// Признак включения НДС в цену товара (определяется системой налогообложения).
//
// Возвращаемое значение:
//   Булево
//
Функция ЦенаВключаетНДС() Экспорт
	
	СистемаНалогообложения = Константы.СистемаНалогообложения.Получить();
	
	ЦенаВключаетНДС = СистемаНалогообложения = Перечисления.СистемыНалогообложения.Общая;
	
	Возврат ЦенаВключаетНДС;
	
КонецФункции

// Истина, если это демоверсия
//
// Возвращаемое значение:
//   Булево
//
Функция ЭтоДемоверсия() Экспорт
	
	Возврат Ложь;
	
КонецФункции

//НАСТРОЙКИ СИНХРОНИЗАЦИИ

// Возвращает вид транспорт сообщений обмена
//
// Возвращаемое значение:
//   Перечисление.ВидыТранспортаСообщенийОбмена
//
Функция ВидТранспортаСинхронизации() Экспорт
	
	ВидТранспорта = ПолучитьЗначениеКонстанты("ВидТранспортаСообщенийОбмена");
	
	Возврат ВидТранспорта;
	
КонецФункции

// Истина, если транспорт сообщений через web-сервис
//
// Возвращаемое значение:
//   Булево
//
Функция ТранспортСинхронизацииЧерезWS() Экспорт
	
	ВидТранспортаСинхронизации = ВидТранспортаСинхронизации();
	
	Если НЕ ЗначениеЗаполнено(ВидТранспортаСинхронизации) Тогда
		СообщениеИсключения = НСтр("ru = 'Константа ""Вид транспорта сообщений обмена"" не заполнена.'");
		ВызватьИсключение СообщениеИсключения;
	КонецЕсли;
	
	ТранспортСинхронизацииЧерезWS = ВидТранспортаСинхронизации = Перечисления.ВидыТранспортаСообщенийОбмена.WS;
	
	Возврат ТранспортСинхронизацииЧерезWS;
	
КонецФункции

// Истина, если выставлен флаг "Загружать настройки"
Функция ЗагружатьНастройки() Экспорт
	
	ЗагружатьНастройки = ПолучитьЗначениеКонстанты("ЗагружатьНастройки");
	
	Возврат ЗагружатьНастройки;
	
КонецФункции

#КонецОбласти