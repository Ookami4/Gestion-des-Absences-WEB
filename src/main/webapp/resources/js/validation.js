function isArabic(str) {
	return  /[\u0600-\u06FF]/.test(str);
} 
function isEmail(str)
{
	return  /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(str.toLowerCase());
}

function isName(str)
{
	return  /^[a-zA-Z ]{2,30}$/.test(str); 
}
function isPhone(str)
{
	return  /^[6|7][0-9]{8}$/.test(str);
}
function isEmpty(str)
{
	return str.trim()==="";
}
function isNumber(str)
{
	if(typeof str == "number") return true;
	return !isNaN(str) && !isNaN(parseFloat(str));
}
function isFloat(str)
{
	return isNumber(str);
}
function isPositiveFloat(str)
{
	return isFloat(str) && parseFloat(str)>0;
}
function isInteger(value)
{
	return !isNaN(value) && parseInt(Number(value)) == value && !isNaN(parseInt(value, 10));
}
function isPositiveInteger(value)
{
	return isInteger(value) && parseInt(value)>0;
}