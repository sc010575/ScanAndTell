//
//  DAZooplaService.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 22/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAZooplaService.h"
#import "DADownloadService.h"
#import "DAResultResponse.h"
#import "DAPlaceMarkCreator.h"

NSString * const Local_Info_Base_URL = @"http://api.zoopla.co.uk/api/v1/local_info_graphs.js?area=";
NSString * const Area_Info_Base_URL = @"http://api.zoopla.co.uk/api/v1/area_value_graphs.js?area=";
NSString * const Area_info_middlePart = @"&output_type=outcode";

NSString * const URL_Endpooint = @"&api_key=cvgzdjcantqwjqzhxujzeckh";


@implementation DAZooplaService

+ (void) requestZooplaServiceForPostCode:(NSString*)postcode
{
    NSArray * const URLRequest =  @[@[Local_Info_Base_URL,@"Social"],
                                    @[Area_Info_Base_URL,@"Area"]];
    for(NSArray* url in URLRequest)
    {
        [self sendDownloadRequestWithURL:url[0] withRequestID:url[1] andPostCode:postcode];
    }
}

+(void) sendDownloadRequestWithURL:(NSString*)URLString withRequestID:(NSString*) requestID andPostCode:(NSString*) postcode
{
    NSString *finalUrl;
    if( [requestID isEqualToString:@"Social"])
    {
        finalUrl = [NSString stringWithFormat:@"%@%@%@",URLString,postcode,URL_Endpooint];
    }
    
    if ([requestID isEqualToString:@"Area"])
    {
        finalUrl = [NSString stringWithFormat:@"%@%@%@%@",URLString,postcode,Area_info_middlePart,URL_Endpooint];
        
    }
        
    DAResultResponse * request = [DAResultResponse alloc];
    [request  initWithRequestID:requestID andURL:finalUrl];
    [[DADownloadService shared] requestForADownload:request];
}

+ (NSString*) URLForDict:(NSDictionary*)dictToAnalyze withService:(ZooplaServices )serviceIndex withIndexPath:(NSIndexPath*)indexpath
{
    NSString * URLToShow;
    if (serviceIndex == zoopla_localinfo ){
        switch (indexpath.row)
        {
            case 0:{
                URLToShow = dictToAnalyze[@"education_graph_url"];
                break;
            }
            case 1:{
                URLToShow = dictToAnalyze[@"council_tax_graph_url"];
                break;
            }
            case 2:{
                URLToShow = dictToAnalyze[@"crime_graph_url"];
                break;
            }
            case 3:{
                URLToShow = dictToAnalyze[@"people_graph_url"];
                break;
            }
            default:
                break;
        }
    }
    else if(serviceIndex == zoopla_areagraph ){
        switch (indexpath.row)
        {
            case 0:{
                URLToShow = dictToAnalyze[@"average_values_graph_url"];
                break;
            }
            case 1:{
                URLToShow = dictToAnalyze[@"value_ranges_graph_url"];
                break;
            }
            case 2:{
                URLToShow = dictToAnalyze[@"value_trend_graph_url"];
                break;
            }
            case 3:{
                URLToShow = dictToAnalyze[@"home_values_graph_url"];
                break;
            }
            default:
                break;
        }
    }
    return URLToShow;
}

@end
