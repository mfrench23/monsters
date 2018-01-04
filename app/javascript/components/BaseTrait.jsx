import React from "react"
import PropTypes from "prop-types"
import QuietLink from "./QuietLink.jsx"

class BaseTrait extends React.Component {
  render () {
    var notes = "";
    if( this.props.trait.notes ) {
      notes = " (" + this.props.trait.notes + ")";
    }
    var level = "";
    if( this.props.trait.level ) {
      level = " " + this.props.trait.level;
    }
    return (
      <span>
        <QuietLink txt={this.props.masterTrait.name} url={this.props.url} popupText={this.props.masterTrait.notes} />{notes}{level}
      </span>
    );
  }
}

BaseTrait.propTypes = {
  trait: PropTypes.object,
  masterTrait: PropTypes.object,
  url: PropTypes.string
};
export default BaseTrait
