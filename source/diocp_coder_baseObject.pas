(*
 *	 Unit owner: d10.天地弦
 *	       blog: http://www.cnblogs.com/dksoft
 *     homePage: www.diocp.org
 *
 *   2015-02-22 08:29:43
 *     DIOCP-V5 发布
 *
 *)
 
unit diocp_coder_baseObject;

interface

uses
  diocp_tcp_server, utils_buffer;

type
{$if CompilerVersion< 18.5}
  TBytes = array of Byte;
{$IFEND}

  TIOCPDecoder = class(TObject)
  public
    /// <summary>
    ///   解码收到的数据,如果有接收到数据,调用该方法,进行解码
    /// </summary>
    /// <returns>
    ///   返回解码好的对象
    /// </returns>
    /// <param name="inBuf"> 接收到的流数据 </param>
    function Decode(const inBuf: TBufferLink; pvContext: TObject): TObject;
        virtual; abstract;
  end;

  TIOCPDecoderClass = class of TIOCPDecoder;

  TIOCPEncoder = class(TObject)
  public
    /// <summary>
    ///   编码要发送的对象
    /// </summary>
    /// <param name="pvDataObject"> 要进行编码的对象 </param>
    /// <param name="ouBuf"> 编码好的数据 </param>
    procedure Encode(pvDataObject: TObject; const ouBuf: TBufferLink); virtual;
        abstract;
  end;

  TIOCPEncoderClass = class of TIOCPEncoder;


  TDiocpEncoder = class(TObject)
  protected
    FContext:TObject;
  public
    procedure SetContext(const pvContext:TObject);
  end;


  /// <summary>
  ///  解码器
  /// </summary>
  TDiocpDecoder = class(TObject)
  protected
    FContext:TObject;
  public
    /// <summary>
    ///   输入数据
    /// </summary>
    procedure OnRecvBuffer(const buf:Pointer; len:Cardinal); virtual; abstract;

    procedure SetContext(const pvContext:TObject);

    /// <summary>
    ///   获取解码好的数据
    /// </summary>
    function GetData:Pointer; virtual; abstract;


    /// <summary>
    ///   释放解码好的数据
    /// </summary>
    procedure ReleaseData(const pvData:Pointer); virtual; abstract;

    /// <summary>
    ///   解码收到的数据,如果有接收到数据,调用该方法,进行解码
    /// </summary>
    /// <returns>
    ///   0：需要更多的数据
    ///   1: 解码成功
    ///  -1: 解码失败
    /// </returns>
    /// <param name="inBuf"> 接收到的流数据 </param>
    function Decode(): Integer;  virtual; abstract;
  end;

  TDiocpDecoderClass = class of TDiocpDecoder;

implementation

procedure TDiocpDecoder.SetContext(const pvContext:TObject);
begin
  FContext := pvContext;
end;

{ TDiocpEncoder }

procedure TDiocpEncoder.SetContext(const pvContext: TObject);
begin
  FContext := pvContext;
end;

end.
