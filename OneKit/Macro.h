
#define iOS ([[[UIDevice currentDevice] systemVersion] floatValue])
#define fix(value) ((NSNull*)value==[NSNull null] ? nil : value)
#define fixWith(value,default) ((NSNull*)value==[NSNull null] ? default : value)
#define isNull(value) ((!value) || ((NSNull*)value == [NSNull null]))
#define notNull(value) (value && ((NSNull*)value != [NSNull null]))
#define array(array,index) ((array && index>=0 && index<array.count) ? array[index] : nil)
#define dict(dict,key) ((dict && notNull(key) && [dict.allKeys containsObject:key]) ? dict[key] : nil)
#define isEmpty(str) ([NSString isEmpty:str])
#define notEmpty(str) (![NSString isEmpty:str])
#define format(str,...) ([NSString stringWithFormat:str,## __VA_ARGS__])
#define alert(str) ([DIALOG alert:str]);
#define loading() ([LOADING show]);
#define done() ([LOADING hide]);
#define toast(str) ([UIView makeToast:str]);
