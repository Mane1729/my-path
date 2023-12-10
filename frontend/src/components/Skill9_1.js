import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import translations from './questionData/MultilinguismData.json';
import './../App.css';
import { useNavigate } from 'react-router-dom';

function shuffleArray(array) {
  let currentIndex = array.length,  randomIndex;

  // While there remain elements to shuffle...
  while (currentIndex !== 0) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }

  return array;
}

function Skill9_1() {
  const [languages, setLanguages] = useState(translations.map(item => item.language));
  const [translationsList, setTranslationsList] = useState(shuffleArray(translations.map(item => item.translation)));

  // Handle the end of a drag event
  const onDragEnd = (result) => {
    // dropped outside the list
    if (!result.destination) {
      return;
    }
  
    const sourceIndex = result.source.index;
    const destIndex = result.destination.index;
  
    // Swapping the translations
    const newTranslations = Array.from(translationsList);
    [newTranslations[sourceIndex], newTranslations[destIndex]] = [newTranslations[destIndex], newTranslations[sourceIndex]];
  
    setTranslationsList(newTranslations);
  };

  const countCorrectMatches = () => {
    return translationsList.reduce((count, translation, index) => {
      if (translation === translations[index].translation) {
        return count + 1;
      }
      return count;
    }, 0);
  };

  const navigate = useNavigate();
  const correctCount = countCorrectMatches();

  const navigateToSkill9_2 = () => {
    navigate('/skill9_2', { state: { correctCount } });
  };

  return (
    <div class="skill">
    <DragDropContext onDragEnd={onDragEnd}>
      <header>
        <h1>Multilingualism</h1>
      </header>
      <h3 className="question_fontsize">Match the languages and corresponding sentences by dragging and dropping them.</h3>
      <div className="table">
        <div className="header language">Languages</div>
        <div className="header translation">Translations</div>

        {languages.map((language, index) => (
          <div className="row" key={`row-${index}-${language}`}>
            <div className="language">{language}</div>
            <Droppable droppableId={`droppable-${index}`}>
              {(provided) => (
                <div
                  ref={provided.innerRef}
                  {...provided.droppableProps}
                  className="translation-container"
                >
                  <Draggable draggableId={`item-${index}`} index={index}>
                    {(provided) => (
                      <div
                        ref={provided.innerRef}
                        {...provided.draggableProps}
                        className="translation"
                      >
                        {/* Drag Handle */}
                        <span 
                          {...provided.dragHandleProps} 
                          className="drag-handle"
                        ></span>
                        <div {...provided.dragHandleProps} className="drag-handle">
                          <div className="drag-row">
                            <span className="drag-dot"></span>
                            <span className="drag-dot"></span>
                          </div>
                          <div className="drag-row">
                            <span className="drag-dot"></span>
                            <span className="drag-dot"></span>
                          </div>
                          <div className="drag-row">
                            <span className="drag-dot"></span>
                            <span className="drag-dot"></span>
                          </div>
                          <div className="drag-row">
                            <span className="drag-dot"></span>
                            <span className="drag-dot"></span>
                          </div>
                        </div>
                        <span className="translation-text">{translationsList[index]}</span>
                      </div>
                    )}
                  </Draggable>
                  {provided.placeholder}
                </div>
              )}
            </Droppable>
          </div>
        ))}
      </div>
      {/* <div className="match-count">
        Correct Matches: {countCorrectMatches()}
      </div> */}
      <button class="skill_nextButton" onClick={navigateToSkill9_2}>Next</button>
    </DragDropContext>
    </div>
  );
}

export default Skill9_1;
