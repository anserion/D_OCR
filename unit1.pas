//Copyright 2020 Andrey S. Ionisyan (anserion@gmail.com)
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BTN_orig1_clear1: TButton;
    BTN_orig1_clear2: TButton;
    BTN_orig1_draw: TButton;
    BTN_orig1_draw1: TButton;
    BTN_orig1_draw2: TButton;
    BTN_orig2_clear: TButton;
    BTN_orig2_clear1: TButton;
    BTN_orig2_clear2: TButton;
    BTN_orig2_draw: TButton;
    BTN_orig2_draw1: TButton;
    BTN_orig2_draw2: TButton;
    BTN_orig3_clear: TButton;
    BTN_orig3_clear1: TButton;
    BTN_orig3_clear2: TButton;
    BTN_orig3_draw: TButton;
    BTN_orig3_draw1: TButton;
    BTN_orig3_draw2: TButton;
    BTN_orig4_clear: TButton;
    BTN_orig4_clear1: TButton;
    BTN_orig4_clear2: TButton;
    BTN_orig4_draw: TButton;
    BTN_orig4_draw1: TButton;
    BTN_orig4_draw2: TButton;
    BTN_orig_create: TButton;
    BTN_orig1_clear: TButton;
    BTN_reset: TButton;
    Edit_student_name: TEdit;
    Label_orig10: TLabel;
    Label_orig11: TLabel;
    Label_orig12: TLabel;
    Label_orig5: TLabel;
    Label_orig6: TLabel;
    Label_orig7: TLabel;
    Label_orig8: TLabel;
    Label_orig9: TLabel;
    Label_student_name: TLabel;
    Label2: TLabel;
    Label_orig1: TLabel;
    Label_orig2: TLabel;
    Label_orig3: TLabel;
    Label_orig4: TLabel;
    PB_orig1: TPaintBox;
    PB_orig10: TPaintBox;
    PB_orig11: TPaintBox;
    PB_orig12: TPaintBox;
    PB_orig2: TPaintBox;
    PB_orig3: TPaintBox;
    PB_orig4: TPaintBox;
    PB_orig5: TPaintBox;
    PB_orig6: TPaintBox;
    PB_orig7: TPaintBox;
    PB_orig8: TPaintBox;
    PB_orig9: TPaintBox;
    PB_receptors: TPaintBox;
    procedure BTN_orig1_drawClick(Sender: TObject);
    procedure BTN_orig_createClick(Sender: TObject);
    procedure BTN_orig1_clearClick(Sender: TObject);
    procedure BTN_resetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PB_orig1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB_orig1Paint(Sender: TObject);
    procedure PB_receptorsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PB_receptorsPaint(Sender: TObject);
  private
    procedure Recognition_step;
    procedure Redraw_orig_cell( Sender: TObject; x,y:integer);
    procedure Redraw_receptor_cell( Sender: TObject; x,y:integer);
    procedure Redraw_widgets;
  public

  end;

const
  n_origs=12;
  s_width=5;
  s_height=5;

var
  Form1: TForm1;

  S_elements: array[1..s_width,1..s_height]of integer;
  Orig_elements: array[1..n_origs,1..s_width,1..s_height]of integer;
  dist: array[1..n_origs]of real;
  min_dist:real;
  min_dist_idx:integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Recognition_step;
var i,cell_x,cell_y:integer;
begin
  for i:=1 to n_origs do
  begin
    dist[i]:=0;
    for cell_x:=1 to s_width do
      for cell_y:=1 to s_height do
        dist[i]:=dist[i]+sqr(Orig_elements[i,cell_x,cell_y]-S_elements[cell_x,cell_y]);
  end;

  min_dist_idx:=1; min_dist:=dist[1];
  for i:=1 to n_origs do
    if min_dist>dist[i] then
    begin
      min_dist:=dist[i];
      min_dist_idx:=i;
    end;
end;

procedure TForm1.Redraw_widgets;
begin
  Label_orig1.Color:=clDefault; Label_orig1.caption:='Эталон 1 ('+FloatToStrF(dist[1],ffFixed,5,3)+')';
  Label_orig2.Color:=clDefault; Label_orig2.caption:='Эталон 2 ('+FloatToStrF(dist[2],ffFixed,5,3)+')';
  Label_orig3.Color:=clDefault; Label_orig3.caption:='Эталон 3 ('+FloatToStrF(dist[3],ffFixed,5,3)+')';
  Label_orig4.Color:=clDefault; Label_orig4.caption:='Эталон 4 ('+FloatToStrF(dist[4],ffFixed,5,3)+')';
  Label_orig5.Color:=clDefault; Label_orig5.caption:='Эталон 5 ('+FloatToStrF(dist[5],ffFixed,5,3)+')';
  Label_orig6.Color:=clDefault; Label_orig6.caption:='Эталон 6 ('+FloatToStrF(dist[6],ffFixed,5,3)+')';
  Label_orig7.Color:=clDefault; Label_orig7.caption:='Эталон 7 ('+FloatToStrF(dist[7],ffFixed,5,3)+')';
  Label_orig8.Color:=clDefault; Label_orig8.caption:='Эталон 8 ('+FloatToStrF(dist[8],ffFixed,5,3)+')';
  Label_orig9.Color:=clDefault; Label_orig9.caption:='Эталон 9 ('+FloatToStrF(dist[9],ffFixed,5,3)+')';
  Label_orig10.Color:=clDefault; Label_orig10.caption:='Эталон 10 ('+FloatToStrF(dist[10],ffFixed,5,3)+')';
  Label_orig11.Color:=clDefault; Label_orig11.caption:='Эталон 11 ('+FloatToStrF(dist[11],ffFixed,5,3)+')';
  Label_orig12.Color:=clDefault; Label_orig12.caption:='Эталон 12 ('+FloatToStrF(dist[12],ffFixed,5,3)+')';

  case min_dist_idx of
  1: Label_orig1.Color:=clGreen;
  2: Label_orig2.Color:=clGreen;
  3: Label_orig3.Color:=clGreen;
  4: Label_orig4.Color:=clGreen;
  5: Label_orig5.Color:=clGreen;
  6: Label_orig6.Color:=clGreen;
  7: Label_orig7.Color:=clGreen;
  8: Label_orig8.Color:=clGreen;
  9: Label_orig9.Color:=clGreen;
  10: Label_orig10.Color:=clGreen;
  11: Label_orig11.Color:=clGreen;
  12: Label_orig12.Color:=clGreen;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BTN_resetClick(self);
end;

procedure TForm1.PB_orig1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var cell_x,cell_y:integer; dx,dy:real;
begin
  with (sender as TPaintBox) do
  begin
    dx:=width/s_width;
    dy:=Height/s_height;
    cell_x:=trunc(X/dx)+1;
    cell_y:=trunc(Y/dy)+1;
    if orig_elements[tag,cell_x,cell_y]=1
    then orig_elements[tag,cell_x,cell_y]:=0
    else orig_elements[tag,cell_x,cell_y]:=1;
    Redraw_orig_cell(Sender,cell_x,cell_y);
  end;
  Recognition_step;
  Redraw_widgets;
end;

procedure TForm1.PB_orig1Paint(Sender: TObject);
var cell_x,cell_y:integer;
begin
  with (sender as TPaintBox) do
    for cell_x:=1 to s_width do
      for cell_y:=1 to s_height do
        Redraw_orig_cell(Sender,cell_x,cell_y);
end;

procedure TForm1.PB_receptorsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var cell_x,cell_y:integer; dx,dy:real;
begin
  with PB_receptors do
  begin
    dx:=width/s_width;
    dy:=Height/s_height;
    cell_x:=trunc(X/dx)+1;
    cell_y:=trunc(Y/dy)+1;
    if S_elements[cell_x,cell_y]=1
    then S_elements[cell_x,cell_y]:=0
    else S_elements[cell_x,cell_y]:=1;
    Redraw_receptor_cell(Sender,cell_x,cell_y);
  end;
  Recognition_step;
  Redraw_widgets;
end;

procedure TForm1.PB_receptorsPaint(Sender: TObject);
var cell_x,cell_y:integer;
begin
  with PB_receptors do
    for cell_x:=1 to s_width do
      for cell_y:=1 to s_height do
        Redraw_receptor_cell(PB_receptors,cell_x,cell_y);
end;

procedure TForm1.Redraw_receptor_cell(Sender:TObject; x,y:integer);
var dx,dy:real;
begin
  with (sender as TPaintBox) do
  begin
    Canvas.Pen.Color:=clBlack;
    Canvas.Brush.Style:=bsSolid;
    dx:=width/s_width;
    dy:=Height/s_height;
    if S_elements[x,y]=1
    then Canvas.Brush.Color:=clBlack
    else Canvas.Brush.Color:=clWhite;
    Canvas.Rectangle(trunc((x-1)*dx),trunc((y-1)*dy),trunc(x*dx),trunc(y*dy));
  end;
end;

procedure TForm1.Redraw_orig_cell(Sender:TObject; x,y:integer);
var dx,dy:real;
begin
  with (sender as TPaintBox) do
  begin
    Canvas.Pen.Color:=clBlack;
    Canvas.Brush.Style:=bsSolid;
    dx:=width/s_width;
    dy:=Height/s_height;
    if Orig_elements[tag,x,y]=1
    then Canvas.Brush.Color:=clBlack
    else Canvas.Brush.Color:=clWhite;
    Canvas.Rectangle(trunc((x-1)*dx),trunc((y-1)*dy),trunc(x*dx),trunc(y*dy));
  end;
end;

procedure TForm1.BTN_orig1_drawClick(Sender: TObject);
var cell_x,cell_y:integer;
begin
  with Sender as TButton do
  begin
    for cell_x:=1 to s_width do
      for cell_y:=1 to s_height do
        S_elements[cell_x,cell_y]:=Orig_elements[tag,cell_x,cell_y];
  end;
  PB_receptorsPaint(PB_receptors);
  Recognition_step;
  Redraw_widgets;
end;

procedure TForm1.BTN_orig_createClick(Sender: TObject);
var i,k,cell_x,cell_y,rnd_x,rnd_y:integer;
begin
  for i:=1 to n_origs do
    for cell_y:=1 to s_width do
      for cell_x:=1 to s_height do
        Orig_elements[i,cell_x,cell_y]:=0;

  for i:=1 to n_origs do
    for k:=1 to 10 do
    begin
      rnd_x:=random(s_width)+1;
      rnd_y:=random(s_height)+1;
      Orig_elements[i,rnd_x,rnd_y]:=1;
    end;

  PB_orig1Paint(PB_orig1);
  PB_orig1Paint(PB_orig2);
  PB_orig1Paint(PB_orig3);
  PB_orig1Paint(PB_orig4);
  PB_orig1Paint(PB_orig5);
  PB_orig1Paint(PB_orig6);
  PB_orig1Paint(PB_orig7);
  PB_orig1Paint(PB_orig8);
  PB_orig1Paint(PB_orig9);
  PB_orig1Paint(PB_orig10);
  PB_orig1Paint(PB_orig11);
  PB_orig1Paint(PB_orig12);

  Recognition_step;
  Redraw_widgets;
end;

procedure TForm1.BTN_orig1_clearClick(Sender: TObject);
var cell_x,cell_y:integer;
begin
  with Sender as TButton do
    for cell_y:=1 to s_width do
      for cell_x:=1 to s_height do
        Orig_elements[tag,cell_x,cell_y]:=0;

  PB_orig1Paint(PB_orig1);
  PB_orig1Paint(PB_orig2);
  PB_orig1Paint(PB_orig3);
  PB_orig1Paint(PB_orig4);
  PB_orig1Paint(PB_orig5);
  PB_orig1Paint(PB_orig6);
  PB_orig1Paint(PB_orig7);
  PB_orig1Paint(PB_orig8);
  PB_orig1Paint(PB_orig9);
  PB_orig1Paint(PB_orig10);
  PB_orig1Paint(PB_orig11);
  PB_orig1Paint(PB_orig12);

  Recognition_step;
  Redraw_widgets;
end;

procedure TForm1.BTN_resetClick(Sender: TObject);
var cell_x,cell_y:integer;
begin
     randomize;

     for cell_x:=1 to s_width do
       for cell_y:=1 to s_height do
         S_elements[cell_x,cell_y]:=0;

     PB_receptorsPaint(self);
     Recognition_step;
     Redraw_widgets;
end;

end.

