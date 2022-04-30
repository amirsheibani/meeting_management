import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/notes/bloc/note_bloc.dart';
import 'package:meeting_management/widget/notes/model/note_model.dart';
import 'package:meeting_management/widget/notes/repository/note_reository.dart';
import 'package:meeting_management/widget/notes/show_note.dart';

import 'notes_list_item.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key, this.title, this.subTitle, this.addNewNote, this.titleStyle, this.addNewNoteStyle, this.subTitleStyle, this.background}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final String? addNewNote;
  final TextStyle? addNewNoteStyle;
  final Color? background;

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late List<Widget> _items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => NoteBloc(context.read<NoteRepository>())..add(const RetrieveNoteEvent()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.background ?? const Color(0xFF030F34),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: double.maxFinite,
              child: ListTile(
                leading: Icon(
                  FeatherIcons.file,
                  size: 32.0,
                  color: AppTheme.colorBox('meeting_color_eight'),
                ),
                title: Text(
                  widget.title ?? '',
                  style: widget.titleStyle ?? const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  widget.subTitle ?? 'Add your notes',
                  style: widget.subTitleStyle ?? const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: BlocListener<NoteBloc, NoteState>(
                  listener: (BuildContext context, NoteState state) {
                    if(state is NoteErrorState){
                      debugPrint('note Ex:${state.props[0]}');
                    }else if(state is NewNoteLoadedState || state is UpdateNoteLoadedState || state is DeleteNoteLoadedState){
                      context.read<NoteBloc>().add(const RetrieveNoteEvent());
                    }
                  },
                  child: BlocBuilder<NoteBloc, NoteState>(
                    builder: (BuildContext context, NoteState state) {
                      _items = [];
                      _items = [
                        NoteAddItem(
                          title: widget.addNewNote,
                          titleStyle: widget.addNewNoteStyle,
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.grey.shade900.withOpacity(0.4),
                                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                    return Material(
                                      child: DialogFrameWidget(
                                        widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.7,
                                        heightScale: 0.7,
                                        leading: Icon(FeatherIcons.edit, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                        title: Text(Languages.of(context).meetingNotesTitle, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                        headerColor: AppTheme.colorBox('meeting_color_four'),
                                        headerHeight: 80,
                                        background: AppTheme.colorBox('meeting_color_eight'),
                                        child: const ShowNoteWidget(),
                                      ),
                                    );
                                  }),
                                );
                              },
                              barrierColor: Colors.transparent,
                            ).then((value) {
                              if (value != null) {
                                NoteModel _noteModel = value[0];
                                context.read<NoteBloc>().add(AddNoteEvent(noteModel: _noteModel));
                              }
                            });
                          },
                        ),
                      ];
                      if (state is RetrieveNoteLoadedState) {
                        List<NoteModel> _dataList = state.props[0] as List<NoteModel>;
                        for (NoteModel item in _dataList) {
                          _items.add(
                            NoteListItem(
                              title: item.title,
                              description: item.description,
                              titleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w500),
                              descriptionStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w500),
                              icon: Icon(FeatherIcons.fileText, size: 24, color: AppTheme.colorBox('meeting_color_seven')),
                              colors: [AppTheme.colorBox('meeting_color_fourteen'), AppTheme.colorBox('meeting_color_fifteen')],
                              iconColor: AppTheme.colorBox('meeting_color_seven'),
                              iconBackground: AppTheme.colorBox('meeting_color_four'),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.grey.shade900.withOpacity(0.4),
                                      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                        return Material(
                                          child: DialogFrameWidget(
                                            widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.7,
                                            heightScale: 0.7,
                                            leading: Icon(FeatherIcons.edit, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                            title: Text(Languages.of(context).meetingNotesTitle, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                            headerColor: AppTheme.colorBox('meeting_color_four'),
                                            headerHeight: 80,
                                            background: AppTheme.colorBox('meeting_color_eight'),
                                            child: ShowNoteWidget(noteModel: item),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                  barrierColor: Colors.transparent,
                                ).then((value) {
                                  if (value != null) {
                                    NoteModel _noteModel = value[0];
                                    context.read<NoteBloc>().add(UpdateNoteEvent(noteModel: _noteModel));
                                  }
                                });
                              },
                              onTapRemove: (){
                                context.read<NoteBloc>().add(DeleteNoteEvent(id: item.id!));
                              },
                            ),
                          );
                        }
                        return ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              return _items[index];
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 8.0,
                              );
                            },
                            itemCount: _items.length);
                      }
                      return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'),strokeWidth: 1.5,));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
