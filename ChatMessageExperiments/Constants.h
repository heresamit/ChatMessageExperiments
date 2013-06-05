//
//  Constants.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

typedef enum
{
    sent = 0,
    received = 1,
    sentSelected = 2,
    receivedSelected = 3
    
}TDTBubbleType;

#define MAXTEXTWIDTH 250.0f
#define YCELLBUFFER 11.0f //This is the top + bottom margin between bubble and UITableViewCell.
#define CORNERRADIUS 8.0f
#define triangleHeight 9.5f
#define triangleWidth 9.5f
#define YTEXTBUFFER 5.0f

#define AVATARPICHEIGHT 30.0f
#define AVATARPICWIDTH 30.0f
#define AVATARXBUFFER 8.0f
#define XTEXTBUFFER 15.0f