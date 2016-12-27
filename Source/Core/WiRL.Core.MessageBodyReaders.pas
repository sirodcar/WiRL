unit WiRL.Core.MessageBodyReaders;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, System.JSON,

  WiRL.Core.Attributes,
  WiRL.Core.Declarations,
  WiRL.Core.Request,
  WiRL.http.Accept.MediaType,
  WiRL.Core.MessageBodyReader,
  WiRL.Core.Exceptions;



  TJSONValueReader = class(TInterfacedObject, IMessageBodyReader)
    function ReadFrom(AParam: TRttiParameter;
      AMediaType: TMediaType; ARequest: TWiRLRequest): TValue;
  end;


  TStreamReader = class(TInterfacedObject, IMessageBodyReader)
    function ReadFrom(AParam: TRttiParameter;
      AMediaType: TMediaType; ARequest: TWiRLRequest): TValue;
  end;



{ TJSONObjectReader }

function TJSONValueReader.ReadFrom(AParam: TRttiParameter;
  AMediaType: TMediaType; ARequest: TWiRLRequest): TValue;
begin
  Result := TJSONObject.ParseJSONValue(ARequest.Content);
end;

{ TStreamReader }

function TStreamReader.ReadFrom(AParam: TRttiParameter;
  AMediaType: TMediaType; ARequest: TWiRLRequest): TValue;
begin
  Result := ARequest.ContentStream;
end;

initialization
  TMessageBodyReaderRegistry.Instance.RegisterReader<TJSONValue>(TJSONValueReader);


